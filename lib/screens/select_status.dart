import 'package:dbms_app/custom_classes/decorations.dart';
import 'package:dbms_app/custom_classes/buttons.dart';
import 'package:flutter/material.dart';

class status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 10.0,
              child: Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    button(data: "Accepted"),
                    button(data: "Done"),
                    button(data: "Picked"),
                    button(data: "Payment Pending"),
                    button(data: "Paid"),
                  ],
                ),
              )),
        );
  }
}
