import 'package:flutter/material.dart';

class CompanyOwnerView extends StatelessWidget {
  const CompanyOwnerView({super.key, this.userId});
  final int? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('user view : user id = $userId'),
      ),
    );
  }
}
