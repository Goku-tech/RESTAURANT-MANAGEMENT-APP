import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_app/custom_classes/menu_card.dart';
import 'package:dbms_app/data_classes/items.dart';
import 'package:dbms_app/screens/admin.dart';
import 'package:dbms_app/screens/cashier.dart';
import 'package:dbms_app/screens/cook.dart';
import 'package:dbms_app/screens/new_order.dart';
import 'package:dbms_app/screens/waiter.dart';
import 'package:dbms_app/services/crud/database.dart';
import 'package:dbms_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:dbms_app/data_classes/menu_item.dart';
import 'package:dbms_app/global.dart';

class addorder extends StatefulWidget {
  @override
  State<addorder> createState() => _addorderState();
}

class _addorderState extends State<addorder> {
  database data = database();

  void callback() {
    setState(() {});
  }

  Widget find_home() {
    if (role == "Waiter") {
      return waiter();
    }

    if (role == "Cashier") {
      return cashier();
    }

    if (role == "Admin") {
      return admin();
    }

    if (role == "Cook") {
      return cook();
    }

    return waiter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              color: Colors.red,
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection("Menu").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        print(true);
                        print(snapshot.data!.docs.length);
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) => menucard(
                                  item: items(
                                      food: snapshot.data!.docs[index]
                                          ['itemName'],
                                      category: snapshot.data!.docs[index]
                                          ['category'],
                                      image: snapshot.data!.docs[index]
                                          ['pictureUrl'],
                                      price: snapshot.data!.docs[index]
                                          ['price'],
                                   itemid: snapshot.data!.docs[index].id,
                                  ),
                                  icons: Icons.add,
                                  resetstate: callback,
                                )));
                      } else {
                        print("NO DATA");
                        return Center(
                            child: Text(
                          "Loading Data",
                          style: TextStyle(color: Colors.black),
                        ));
                      }
                    } else {
                      print("NO Connection");
                      return Center(
                          child: Text(
                        "Loading Data",
                        style: TextStyle(color: Colors.black),
                      ));
                    }

                    return Center(
                        child: Text(
                      "Loading Data",
                      style: TextStyle(color: Colors.black),
                    ));
                  }),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => wrapper(
                              default_page: find_home(),
                              current_page: neworder())));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    fixedSize:
                        MaterialStateProperty.all(const Size(150.0, 35.0))),
                child: Text("Done",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
