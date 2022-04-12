import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapi_demo/Login/Login_state_notifier.dart';
import 'package:googleapi_demo/Login/home_screen.dart';
import 'package:googleapi_demo/Login/login_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = StateNotifierProvider<LoginStateNotifier, LoginState>(
        (_) => LoginStateNotifier());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () async {
              await ref.read(loginProvider.notifier).handleSignIn();

              if (ref.watch(loginProvider).isLogin) {
                _onLoginSuccessful(context, ref.watch(loginProvider).user);
              } else {
                _onLoginFailed;
              }
            },
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            label: const Text('Sign Up With Google')),
      ),
    );
  }

  Future<void> _onLoginSuccessful(
      BuildContext context, GoogleSignInAccount? user) async {
    if (user == null) {
      log('error');
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
    }
  }

  Future<void> _onLoginFailed(BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('SignIn Failed')));
  }
}
