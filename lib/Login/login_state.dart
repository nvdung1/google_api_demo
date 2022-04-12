import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState(
      {@Default(false) bool isLogin,
      @Default(false) bool showLoadingIndicator,
      GoogleSignInAccount? user}) = _LoginState;
}
