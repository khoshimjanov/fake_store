import 'package:fake_store/features/login/presentation/bloc/logout/logout_bloc.dart';
import 'package:fake_store/features/login/presentation/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                context.read<LogoutBloc>().add(const LogoutEvent.logout());
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                    (route) => false);
              },
              color: Colors.red,
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
