
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
   final Function() handler;
   AdaptiveFlatButton(this.handler);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Platform.isIOS
            ? CupertinoButton(
          onPressed: handler,
          child: Text(
            "Choose Data",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : InkWell(
          child: Icon(
            Icons.date_range_outlined,
            size: 35,
            color: Colors.black,
          ),
          onTap: handler,
        ),
      ),
    );
  }
}
