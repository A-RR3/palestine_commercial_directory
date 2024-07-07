import 'package:flutter/material.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';

import '../../core/presentation/Palette.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.hint,
    this.onChanged,
  });
  final String hint;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.deviceSize.width * .8,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.25),
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintStyle:
                  context.textTheme.bodyMedium!.copyWith(color: Palette.border),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: hint,
              hintMaxLines: 1,
              icon: const Icon(Icons.search),
              border: InputBorder.none,
              alignLabelWithHint: true),
        ));
  }
}
