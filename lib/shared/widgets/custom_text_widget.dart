import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos_application/core/utils/extensions.dart';

import '../../core/presentation/Palette.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({super.key, required this.text, this.style, this.color});
  final String text;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          context.textTheme.bodyLarge!
              .copyWith(color: color ?? Palette.border),
    );
  }
}
