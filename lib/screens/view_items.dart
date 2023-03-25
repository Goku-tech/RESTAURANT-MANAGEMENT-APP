import 'package:dbms_app/custom_classes/menu_card.dart';
import 'package:dbms_app/data_classes/items.dart';
import 'package:flutter/material.dart';

class viewitems extends StatefulWidget {
  @override
  State<viewitems> createState() => _viewitemsState();
}

class _viewitemsState extends State<viewitems> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> order_details;
    order_details = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    void callback() {
      setState(() {});
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Text("Ordered Items", style: TextStyle(fontSize: 30.0)),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              color: Colors.red,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: order_details.length,
                  itemBuilder: (((context, index) {
                    return menucard(
                        item: items(
                            image: 'assets/pizza.png',
                            food: order_details[index]['itemName'],
                            price: order_details[index]['price'],
                            category: order_details[index]['category'],
                            quantity:order_details[index]['quantity']),
                        icons: Icons.food_bank_rounded,
                        resetstate: callback);
                  }))),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[500]),
                    fixedSize:
                        MaterialStateProperty.all(const Size(150.0, 35.0))),
                child: Text("Go Back",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
