// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSpecificLoader extends StatelessWidget {
  const PlatformSpecificLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoActivityIndicator(
            color: Theme.of(context).primaryColor,
            radius: 15,
          )
        : SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 3,
            ),
          ));
  }
}
