import 'package:flutter/material.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/theme.dart';

class RemoveButton extends StatelessWidget {
  void Function()? func;

  RemoveButton({this.func});
  @override
  Widget build(BuildContext context) {
    return UserPrefs.getIsCollabOwner()? Container(
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80), color: Colors.redAccent),
        child: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            onPressed: func,
            icon: Icon(Icons.person_remove_sharp, size: 25)),
      ),
    ):Container();
  }
}
