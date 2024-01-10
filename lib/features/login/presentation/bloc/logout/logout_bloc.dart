import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(_Initial()) {
    on<_Logout>((event, emit) async {
      final pref = await SharedPreferences.getInstance();
      await pref.remove('token');
      // TODO: implement event handler
    });
  }
}
