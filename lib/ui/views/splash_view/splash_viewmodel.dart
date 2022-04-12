import 'package:blindside/app/_app.dart';
import 'package:blindside/services/_services.dart';
import 'package:blindside/ui/constants/_constants.dart';
import 'package:blindside/ui/constants/videos.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewmodel extends BaseViewModel {
  final _authService = locator<IAuthenticationService>();
  final _navService = locator<NavigationService>();
  final _storageService = locator<IStorageService>();

  void init() async {
    await _storageService.setMap(AppStrings.videoData, data);
  }

  Future<void> checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    if (_authService.currentUser == null) {
      _navService.replaceWith(Routes.loginView);
    } else {
      _navService.replaceWith(Routes.homeView);
    }
  }
}
