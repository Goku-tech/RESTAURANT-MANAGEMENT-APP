import 'dart:math';

import 'package:dbms_app/custom_classes/buttons.dart';
import 'package:dbms_app/custom_classes/decorations.dart';
import 'package:dbms_app/data_classes/items.dart';
import 'package:dbms_app/global.dart';
import 'package:flutter/material.dart';

class additem extends StatefulWidget {
  @override
  State<additem> createState() => _additemState();
}

class _additemState extends State<additem> {
  String quantity = null.toString();

  String itemname = '';
  String itemprice = '';
  String category = '';

  String itemid = Random.secure().nextInt(100).toString();

  String error = '';

  @override
  Widget build(BuildContext context) {
    //Getting the itemdetails from the menu_card page;
    Map<String, dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    itemname = argument["itemname"];
    itemprice = argument["itemprice"];
    category = argument["category"];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.red[500],
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.all(35.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 10.0,
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text("Add Item", style: TextStyle(fontSize: 30.0)),
                  ),
                  SizedBox(height: 5.0),
                  Text("Item Name:${itemname}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 5.0),
                  Text("Item ID:${itemid}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 5.0),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: decorations()
                        .formDecor()
                        .copyWith(hintText: "Enter Quantity"),
                    onChanged: (credential) {
                      quantity = credential;
                    },
                    showCursor: true,
                  ),
                  Column(
                    children: [
                      SizedBox(height: 2.0),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              if (quantity == null.toString()) {
                                setState(() {
                                  error = "Enter Quantity";
                                });
                              } else {
                                food_items.add(items(
                                    image: 'assets/pizza.png',
                                    food: itemname,
                                    price: itemprice,
                                    category: category,
                                    quantity:quantity,
                                    itemid:argument["itemid"]
                                    ));

                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Confirm",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red[500]),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(150.0, 35.0)))),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
