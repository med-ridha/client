import 'package:flutter/material.dart';
import 'package:juridoc/theme.dart';

class RoundedTextContainer extends StatelessWidget {
  final Widget? child;
  final bool? error;
  const RoundedTextContainer({
    Key? key,
    this.child,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: kTextFieldColor,
            borderRadius: BorderRadius.circular(29),
            border: (this.error ?? false)
                ? Border.all(width: 1.5, color: Colors.red)
                : null),
        child: this.child);
  }
}
