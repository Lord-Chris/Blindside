import 'package:blindside/app/_app.dart';
import 'package:blindside/core/mixins/toast_mixin.dart';
import 'package:blindside/core/models/_models.dart';
import 'package:blindside/services/_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewmodel extends BaseViewModel with ToastMixin {
  final _authService = locator<IAuthenticationService>();
  final _navService = locator<NavigationService>();

  bool showPassword = false;

  Future<void> onSignInPress(String email, String password) async {
    try {
      setBusy(true);
      await _authService.signInWithEmailAndPassword(email, password);
      setBusy(false);
      _navService.replaceWith(Routes.homeView);
      showSuccessToast("Login Successful!");
    } on Failure catch (e) {
      setBusy(false);
      showFailureToast(e.toString());
    }
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void navigateToSignUp() {
    _navService.replaceWith(Routes.signUpView);
  }
}
