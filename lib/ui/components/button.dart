import 'package:flutter/material.dart';

import '../constants/_constants.dart';

class AppButton extends StatefulWidget {
  final void Function()? onTap;
  final double? width, height, borderRadius;
  final Color? buttonColor;
  final String label;
  final Color? labelColor, loaderColor, borderColor;
  final bool hasShadow, hasBorder, isBusy, enabled;
  final FontWeight fontWeight;
  final Widget? icon;
  const AppButton({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.icon,
    this.buttonColor = AppColors.main,
    required this.label,
    this.labelColor = AppColors.white,
    this.loaderColor = AppColors.white,
    this.borderColor,
    this.hasShadow = false,
    this.hasBorder = false,
    this.isBusy = false,
    this.fontWeight = FontWeight.w600,
    this.borderRadius,
    this.enabled = true,
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isTappedDown = false;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return RepaintBoundary(
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        onTapDown: (tapDownDetails) {
          setState(() {
            isTappedDown = true;
          });
        },
        onTapUp: (tapUpDetails) {
          setState(() {
            isTappedDown = false;
          });
        },
        onTapCancel: () {
          setState(() {
            isTappedDown = false;
          });
        },
        child: Opacity(
          opacity: isTappedDown || !widget.enabled ? 0.6 : 1.0,
          child: Container(
            width: widget.width ?? screenWidth * 0.8,
            height: widget.height ?? screenHeight * 0.075,
            decoration: BoxDecoration(
              color: widget.buttonColor,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 15),
              border: widget.hasBorder
                  ? Border.all(
                      color: widget.borderColor ?? Colors.grey[400]!,
                      width: 1,
                    )
                  : null,
              boxShadow: [
                if (widget.hasShadow)
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                  )
              ],
            ),
            child: Center(
              child: Visibility(
                visible: !widget.isBusy,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.icon != null)
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: widget.icon,
                      ),
                    Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.labelColor,
                        fontSize: 20,
                        fontWeight: widget.fontWeight,
                      ),
                    ),
                  ],
                ),
                replacement: CircularProgressIndicator(
                  color: widget.loaderColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
