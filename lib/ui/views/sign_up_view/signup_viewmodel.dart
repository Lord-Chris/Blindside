import 'package:blindside/app/_app.dart';
import 'package:blindside/core/mixins/_mixins.dart';
import 'package:blindside/services/_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel with ToastMixin {
  final _authService = locator<IAuthenticationService>();
  final _navService = locator<NavigationService>();

  bool showPassword = false;

  Future<void> onSignUpPress(String email, String password) async {
    try {
      setBusy(true);
      await _authService.signUpWithEmailAndPassword(email, password);
      setBusy(false);
      _navService.replaceWith(Routes.loginView);
      showSuccessToast("Sign up successful!");
    } on Exception catch (e) {
      setBusy(false);
      showFailureToast(e.toString());
    }
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void navigateToLogIn() {
    _navService.replaceWith(Routes.loginView);
  }
}
