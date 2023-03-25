import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_app/custom_classes/order_card.dart';
import 'package:dbms_app/data_classes/table_details.dart';
import 'package:flutter/material.dart';

class orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (((context, index) {
                  return order_details(
                      orders: order_data(
                          order_image: 'assets/order.png',
                          orderid: snapshot.data!.docs[index].id,
                          table_num: snapshot.data!.docs[index]['tableNumber'],
                          last_update: snapshot.data!.docs[index]
                              ['lastUpdatedAt']));
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
