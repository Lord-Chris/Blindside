import 'package:blindside/ui/constants/_constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  final _model = SplashViewmodel();
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
        _model.checkUserStatus();
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
    return ViewModelBuilder<SplashViewmodel>.reactive(
        viewModelBuilder: () => _model,
        onModelReady: (model) => model.init(),
        builder: (context, model, __) {
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
        });
  }
}
