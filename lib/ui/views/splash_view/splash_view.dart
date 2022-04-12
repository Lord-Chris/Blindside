import 'package:blindside/app/_app.dart';
import 'package:blindside/services/_services.dart';
import 'package:blindside/ui/constants/_constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  final _authService = locator<IAuthenticationService>();
  final _navService = locator<NavigationService>();

  Future<void> checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    if (_authService.currentUser == null) {
      _navService.replaceWith(Routes.loginView);
    } else {
      _navService.replaceWith(Routes.homeView);
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animation =
        Tween<double>(begin: 0.0, end: 1).animate(_animationController!);
    _animationController?.forward();
    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkUserStatus();
      }
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RotationTransition(
        turns: _animationController!,
        child: SizeTransition(
          sizeFactor: _animationController!,
          child: const Center(
            child: Text(
              AppStrings.appName,
              style: kHeaderStyle,
            ),
          ),
        ),
      ),
    );
  }
}
