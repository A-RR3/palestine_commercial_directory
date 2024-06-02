import 'package:flutter/material.dart';
import 'package:videos_application/core/presentation/palette.dart';

class CustomMaterialBotton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? height;
  const CustomMaterialBotton(
      {super.key, required this.onPressed, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide.none,
      ),
      onPressed: onPressed,
      color: Palette.black,
      minWidth: double.infinity,
      height: height ?? 70,
      child: child,
    );
  }
}
