import 'package:dbms_app/custom_classes/decorations.dart';
import 'package:dbms_app/custom_classes/menu_card.dart';
import 'package:dbms_app/data_classes/items.dart';
import 'package:dbms_app/global.dart';
import 'package:dbms_app/screens/admin.dart';
import 'package:dbms_app/screens/cashier.dart';
import 'package:dbms_app/screens/cook.dart';
import 'package:dbms_app/screens/addorder.dart';
import 'package:dbms_app/screens/waiter.dart';
import 'package:dbms_app/services/crud/database.dart';
import 'package:dbms_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

class new_ordercard extends StatefulWidget {
  String table_number;
  String waiter;
  Function setState;
  String error = '';

  new_ordercard(
      {required this.table_number,
      required this.waiter,
      required this.setState});

  @override
  State<new_ordercard> createState() => _new_ordercardState();
}

class _new_ordercardState extends State<new_ordercard> {
  Future<void> add_order() async {
    database order = database();
    print(widget.waiter);
    print(widget.table_number);
    await order.addorder(
        waiter_name: widget.waiter, table_number: widget.table_number);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                wrapper(default_page: waiter(), current_page: waiter())));
  }

  Widget find_role() {
    if (role == "Waiter") {
      return waiter();
    } else if (role == "Admin") {
      return admin();
    } else if (role == "Cook") {
      return cook();
    } else if (role == "Cashier") {
      return cashier();
    }

    return waiter();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(35.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
              child: Text("New Order", style: TextStyle(fontSize: 30.0)),
            ),
            SizedBox(height: 5.0),
            Text("Waiter:${widget.waiter}",
                textAlign: TextAlign.start, style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 10.0),
            Text("Enter Table Number:",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 15.0),
            TextField(
              textAlign: TextAlign.center,
              decoration: decorations()
                  .formDecor()
                  .copyWith(hintText: "Enter Table Number"),
              onChanged: (credential) {
                widget.table_number = credential;
              },
              showCursor: true,
            ),
            Column(
              children: [
                SizedBox(height: 2.0),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => wrapper(
                                    default_page: find_role(),
                                    current_page: addorder())));
                      },
                      child: Text(
                        "Edit Order",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[500]),
                          fixedSize: MaterialStateProperty.all(
                              const Size(150.0, 35.0)))),
                ),
                SizedBox(height: 2.0),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (widget.table_number == null.toString()) {
                          setState(() {
                            widget.error = "Enter Table Number";
                          });
                        } else {
                          add_order();
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
                  widget.error,
                  style: TextStyle(color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
