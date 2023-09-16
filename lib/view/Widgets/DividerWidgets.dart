import 'package:flutter/material.dart';
class DividerWidgets extends StatelessWidget {
  const DividerWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return  Divider(
      height: 1,
      color: Colors.grey,
      thickness: 0.6,
    );
  }
}
