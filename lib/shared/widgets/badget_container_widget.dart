import 'package:flutter/material.dart';

class BadgedContainer extends StatelessWidget {
  const BadgedContainer({super.key, required this.icon, this.onTap});
  final Icon icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: Colors.red,
      smallSize: 0,
      largeSize: 20,
      offset: const Offset(-2, 2),
      label: const Text('5',
          style: TextStyle(
            fontSize: 14,
          )),
      padding: const EdgeInsets.only(right: 5, left: 5, bottom: 1, top: 0),
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
