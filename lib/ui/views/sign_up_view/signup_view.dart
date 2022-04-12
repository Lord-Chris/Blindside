import 'package:blindside/core/mixins/_mixins.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/_components.dart';
import '../../constants/_constants.dart';
import 'signup_viewmodel.dart';

class SignUpView extends StatelessWidget with ValidationMixin {
  SignUpView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, __) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    const Text(
                      "Welcome to",
                      style: kMainStyle,
                    ),
                    const YMargin(20),
                    const Text(
                      AppStrings.appName,
                      style: kHeaderStyle,
                    ),
                    const YMargin(40),
                    const Text(
                      "The number one video app for everyone",
                      style: kBodyStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    AppTextField(
                      hint: "Email Address",
                      validator: validateEmail,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const YMargin(15),
                    AppTextField(
                      hint: "PassWord",
                      validator: passwordValidation,
                      controller: _passwordController,
                      obscureText: !model.showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      suffix: InkWell(
                        onTap: () => model.togglePasswordVisibility(),
                        child: model.showPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    const YMargin(15),
                    AppTextField(
                      hint: "Confirm PassWord",
                      validator: (val) => confirmPasswordValidation(
                          val, _passwordController.text),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !model.showPassword,
                      maxLines: 1,
                      suffix: InkWell(
                        onTap: () => model.togglePasswordVisibility(),
                        child: model.showPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    const Spacer(flex: 2),
                    Center(
                      child: AppButton(
                        isBusy: model.isBusy,
                        label: "SIGN UP",
                        onTap: () {
                          if (!_formKey.currentState!.validate()) return;
                          model.onSignUpPress(
                              _emailController.text, _passwordController.text);
                        },
                      ),
                    ),
                    const YMargin(20),
                    Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: kSubBodyStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Log In',
                            style: kSubBodyStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.main),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => model.navigateToLogIn(),
                          )
                        ],
                      ),
                    ),
                    const YMargin(32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
