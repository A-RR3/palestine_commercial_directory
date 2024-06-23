import 'package:flutter/material.dart';
import 'package:videos_application/core/presentation/palette.dart';

class CustomMaterialBotton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final bool isDisabled;
  final bool hasPadding;
  final Color? color;

  const CustomMaterialBotton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.height,
      this.width,
      this.color,
      this.isDisabled = false,
      this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide.none,
      ),
      onPressed: onPressed,
      color: color ?? Palette.black,
      minWidth: width ?? double.infinity,
      height: height ?? 50,
      disabledColor: Colors.black.withOpacity(.8),
      disabledTextColor: Colors.white.withOpacity(.8),
      child: child,
      padding:
          hasPadding ? EdgeInsets.symmetric(horizontal: 20) : EdgeInsets.zero,
    );
  }
}
