import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';



  void showSuccess(BuildContext context, String message,
      {bool shouldDismiss = true}) {
    Timer.run(() =>
        _showAlert(context, message, Color(0xFFE2F8FF),
            CupertinoIcons.check_mark_circled_solid,
            Color.fromRGBO(91, 180, 107, 1), shouldDismiss));
  }

  void showInfo(BuildContext context, String message,
      {bool shouldDismiss = true}) {
    Timer.run(() =>
        _showAlert(context, message, Color(0xFFE7EDFB), Icons.info_outline,
            Color.fromRGBO(54, 105, 214, 1), shouldDismiss));
  }

  void showError(BuildContext context, String message,
      {bool shouldDismiss = true}) {
    Timer.run(() =>
        _showAlert(context, message, Color(0xFFFDE2E1), Icons.error_outline,
            Colors.red, shouldDismiss));
  }

  void _showAlert(BuildContext context, String message, Color color,
      IconData icon, Color iconColor, bool shouldDismiss) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          if (shouldDismiss) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context, rootNavigator: true).pop(true);
            });
          }
          return Material(
            type: MaterialType.transparency,
            child: WillPopScope(
              onWillPop: () async => false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.vertical(top:Radius.circular(10),bottom: Radius.circular(10)),
                      color: color
                    ),
                    width: MediaQuery.of(context).size.width-40,
                    height: MediaQuery.of(context).size.height/9,
                    padding: const EdgeInsets.all(5) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 30,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(message,
                          style: TextStyle(decoration: TextDecoration.none,
                          color: Colors.black),),
                        ),
                      ],
                    ),
                  ),

                ),
              ),

            ),
          );
        });
  }
