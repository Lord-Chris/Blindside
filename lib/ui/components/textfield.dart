// ignore_for_file: must_be_immutable

import 'package:blindside/ui/constants/_constants.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  bool? obscureText;
  final int? maxLines;

  AppTextField({
    Key? key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.validator,
    this.onChanged,
    this.suffix,
    this.prefix,
    this.keyboardType,
    this.textCapitalization,
    this.obscureText,
    this.maxLines,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      cursorColor: AppColors.main,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      maxLines: maxLines,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      style: const TextStyle(
        color: AppColors.main,
        fontSize: 20,
        fontWeight: FontWeight.normal,
        // fontFamily: 'G/TWalsheimPro',
      ),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: suffix,
        prefixIcon: prefix,
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.main.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.main.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.main.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        labelStyle: const TextStyle(
          color: AppColors.main,
          fontSize: 20,
          fontWeight: FontWeight.normal,
          // fontFamily: 'GTWalsheimPro',
        ),
        hintStyle: TextStyle(
          color: AppColors.main.withOpacity(0.30),
          fontSize: 20,
          fontWeight: FontWeight.normal,
          // fontFamily: 'GTWalsheimPro',
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.main,
            width: 2,
          ),
        ),
      ),
    );
  }
}
