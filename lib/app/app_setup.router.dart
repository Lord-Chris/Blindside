// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../core/models/video_model.dart';
import '../ui/views/home_view/home_view.dart';
import '../ui/views/login_view/login_view.dart';
import '../ui/views/sign_up_view/signup_view.dart';
import '../ui/views/splash_view/splash_view.dart';
import '../ui/views/video_detail_view/video_detail_view.dart';

class Routes {
  static const String splashView = '/';
  static const String signUpView = '/sign-up-view';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String videoDetailView = '/video-detail-view';
  static const all = <String>{
    splashView,
    signUpView,
    loginView,
    homeView,
    videoDetailView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.videoDetailView, page: VideoDetailView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const SplashView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      var args = data.getArgs<SignUpViewArguments>(
        orElse: () => SignUpViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SignUpView(key: args.key),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    HomeView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    VideoDetailView: (data) {
      var args = data.getArgs<VideoDetailViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => VideoDetailView(
          key: args.key,
          video: args.video,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SignUpView arguments holder class
class SignUpViewArguments {
  final Key? key;
  SignUpViewArguments({this.key});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}

/// VideoDetailView arguments holder class
class VideoDetailViewArguments {
  final Key? key;
  final VideoModel video;
  VideoDetailViewArguments({this.key, required this.video});
}
