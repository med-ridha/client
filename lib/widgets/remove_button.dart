import 'package:flutter/material.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/theme.dart';

class RemoveButton extends StatelessWidget {
  void Function()? func;
  String? email;
  IconData? icon;
  double? size;

  RemoveButton({this.func, this.email, this.icon, this.size});
  @override
  Widget build(BuildContext context) {
    return (UserPrefs.getIsCollabOwner() || UserPrefs.getEmail() == email)? Container(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80), color: Colors.redAccent),
        child: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            onPressed: func,
            icon: Icon(icon ?? Icons.person_remove_sharp, size: size ?? 25)),
      ),
    ):Container();
  }
}
