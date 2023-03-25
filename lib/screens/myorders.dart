import 'package:dbms_app/custom_classes/order_card.dart';
import 'package:dbms_app/data_classes/table_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_app/global.dart';

class myorders extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> orderdetails = [];
  bool is_valid_order = false;

  void isvalid(List<QueryDocumentSnapshot<Object?>> snapshot) {
    orderdetails = [];
    for (var i = 0; i < snapshot.length; i++) {
      if (role == "Waiter") {
        if (name == snapshot[i]['waiterUsername']) {
          orderdetails.add(snapshot[i]);
        }
      } else if (role == "Cook") {
        if (name == snapshot[i]['cookUsername']) {
          orderdetails.add(snapshot[i]);
        }
      } else {
        orderdetails.add(snapshot[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!.docs.isNotEmpty) {
            isvalid(snapshot.data!.docs);

            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: orderdetails.length,
                itemBuilder: (((context, index) {
                  return order_details(
                      orders: order_data(
                          order_image: 'assets/order.png',
                          orderid: orderdetails[index].id,
                          table_num: orderdetails[index]['tableNumber'],
                          last_update: orderdetails[index]['lastUpdatedAt']));
                })));
          } else {
            print("NO DATA");
            return Center(
                child: Text(
              "Loading Data",
              style: TextStyle(color: Colors.black),
            ));
          }
        });
  }
}
