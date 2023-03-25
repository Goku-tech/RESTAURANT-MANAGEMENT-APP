import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_app/custom_classes/menu_card.dart';
import 'package:dbms_app/data_classes/items.dart';
import 'package:dbms_app/screens/new_order.dart';
import 'package:dbms_app/screens/waiter.dart';
import 'package:dbms_app/services/crud/database.dart';
import 'package:dbms_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:dbms_app/data_classes/menu_item.dart';

class menu extends StatefulWidget {
  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  database data = database();

  void callback() {
    setState(() {});
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
                                          ['price']),
                                  icons: Icons.food_bank,
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
          ],
        ),
      ),
    );
  }
}
