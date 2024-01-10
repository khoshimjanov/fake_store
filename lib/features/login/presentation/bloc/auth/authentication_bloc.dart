import 'package:bloc/bloc.dart';
import 'package:fake_store/core/injector/setup_locator.dart';
import 'package:fake_store/features/login/domain/usecase/get_user.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

part 'authentication_bloc.freezed.dart';
 
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<_GetAuthenticationStatus>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      final pref = await SharedPreferences.getInstance();
      if (pref.getString('token') == null) {
        emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
        ));
      }
      {
        emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.authenticated,
        ));
      }
    });

    on<_AuthenticationLoginEvent>((event, emit) async {
      final response =
          await GetUserUseCase().call((event.username, event.password));

      response.either(
        (failure) {
          emit(state.copyWith(
              authenticationStatus: AuthenticationStatus.unauthenticated));
          event.onFailure('Failed to auth');
        },
        (user) async {
          await serviceLocator<SharedPreferences>();
          await SharedPreferences.getInstance().then((value) {
            value.setString('token', 'token');
          });

          emit(state.copyWith(
            authenticationStatus: AuthenticationStatus.authenticated,
            authenticatedUser: user,
          ));

          event.onSuccess();
        },
      );
    });
  }
}
