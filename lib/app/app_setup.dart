import 'package:blindside/services/_services.dart';
import 'package:blindside/ui/views/home_view/home_view.dart';
import 'package:blindside/ui/views/login_view/login_view.dart';
import 'package:blindside/ui/views/sign_up_view/signup_view.dart';
import 'package:blindside/ui/views/splash_view/splash_view.dart';
import 'package:blindside/ui/views/video_detail_view/video_detail_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    AdaptiveRoute(page: SplashView, initial: true),
    AdaptiveRoute(page: SignUpView),
    AdaptiveRoute(page: LoginView),
    AdaptiveRoute(page: HomeView),
    AdaptiveRoute(page: VideoDetailView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(
        classType: AuthenticationService, asType: IAuthenticationService),
    LazySingleton(classType: VideoService, asType: IVideoService),
  ],
)
class AppSetup {}
