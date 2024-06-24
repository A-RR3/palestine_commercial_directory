import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? hintText;
  final String? labelText;

  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final InputBorder? border;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final TextStyle? textStyle;
  final bool filled;
  final Color? fillColor;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      this.onChanged,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.border,
      required this.textInputType,
      this.suffixIcon,
      this.obscureText = false,
      this.focusNode,
      this.textInputAction,
      this.onFieldSubmitted,
      this.textStyle,
      this.fillColor,
      this.filled = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {},
      enableInteractiveSelection: true,
      controller: controller,
      keyboardType: textInputType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          fillColor: filled
              ? fillColor ?? Colors.white.withOpacity(.5)
              : null,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: border ??
              const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide.none),
          suffixIcon: suffixIcon,
          enabledBorder: border,
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(vertical: 9.0)),
      obscureText: obscureText,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: textStyle ?? const TextStyle(fontFamily: 'CairoMedium', fontSize: 18),
    );
  }
}
