import 'package:flutter/material.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';

class BadgedContainer extends StatelessWidget {
  const BadgedContainer({super.key, required this.icon, this.onTap});
  final Icon icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Badge(
      smallSize: 0,
      largeSize: 20,
      offset: Offset(-2, 2),
      label: Text('5',
          style: TextStyle(
            fontSize: 14,
          )),
      padding: EdgeInsets.only(right: 5, left: 5, bottom: 1, top: 0),
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 45,
          width: 45,
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 20,
                spreadRadius: -15,
                blurStyle: BlurStyle.outer,
                color: Theme.of(context).colorScheme.secondary)
          ]),
          child: icon,
        ),
      ),
    );
  }
}
