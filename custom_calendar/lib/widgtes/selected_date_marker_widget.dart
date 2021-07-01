import 'package:flutter/material.dart';

class SelectedDateMarker extends StatelessWidget {
  final Widget child;

  const SelectedDateMarker({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
