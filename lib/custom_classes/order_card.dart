import 'package:dbms_app/data_classes/items.dart';
import 'package:dbms_app/data_classes/table_details.dart';
import 'package:dbms_app/services/crud/database.dart';
import 'package:flutter/material.dart';

class order_details extends StatelessWidget {
  order_data orders;
  order_details({required this.orders});

  Future<String> getprice(String orderID) async {
    database data = database();

    String totalprice = await data.get_price(orderID);
    print(totalprice);
    return totalprice;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        database data = database();

        Map<String, dynamic> order_details =
            await data.getstatus(orders.orderid);
        String price = await getprice(orders.orderid);

        Navigator.pushNamed(context, '/order_status',
            arguments: [order_details, price]);
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          margin: EdgeInsets.all(8.0),
          elevation: 10.0,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  orders.order_image,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Order ID:${orders.orderid}",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5.0),
                  Text("Table Number:${orders.table_num}"),
                  SizedBox(height: 5.0),
                  Text("Last Update:${orders.last_update}PM")
                ],
              ),
            ),
          ])),
    );
  }
}
