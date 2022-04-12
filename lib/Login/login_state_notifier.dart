import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapi_demo/Login/login_state.dart';
import 'package:googleapi_demo/Login/seasion/local_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginStateNotifier, LoginState>(
    (_) => LoginStateNotifier());

class LoginStateNotifier extends StateNotifier<LoginState> {
  LoginStateNotifier() : super(LoginState());
  static final _googleSignIn = GoogleSignIn(
    scopes: ['profile', 'email'],
  );

  Future<void> checkIsLogin() async {
    final accessToken = await LocalStorage.getAccessToken();
    if (accessToken == '') {
      state = state.copyWith(isLogin: true);
    } else {
      state = state.copyWith(isLogin: false);
    }
  }

  Future<void> handleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();
      var googleKey = await user?.authentication;
      await LocalStorage.saveAccessToken(googleKey!.accessToken ?? '');
      state = state.copyWith(isLogin: true, user: user);
    } catch (error) {
      log(error.toString());
      state = state.copyWith(isLogin: false);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await LocalStorage.deleteAccessToken();
    state = state.copyWith(isLogin: false);
  }
}
