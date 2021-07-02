import 'package:flutter/material.dart';

class SelectedDateMarker extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const SelectedDateMarker({
    Key? key,
    required this.child,
    this.width = 30,
    this.height = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
