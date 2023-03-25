import 'package:dbms_app/data_classes/items.dart';
import 'package:dbms_app/data_classes/menu_item.dart';
import 'package:dbms_app/global.dart';
import 'package:flutter/material.dart';

class menucard extends StatefulWidget {
  items item;
  IconData icons;
  Function resetstate;

  menucard({required this.item, required this.icons, required this.resetstate});

  @override
  State<menucard> createState() => _menucardState();
}

class _menucardState extends State<menucard> {
  void addfooditem(BuildContext context) {
    Navigator.pushNamed(context, "/add_item", arguments: {
      "itemname": widget.item.food,
      "itemprice": widget.item.price,
      "category": widget.item.category,
      "itemid": widget.item.itemid
    });
  }

  void removefooditem(BuildContext context) {
    for (var i = 0; i < food_items.length; i++) {
      if (food_items[i].food == widget.item.food &&
          food_items[i].price == widget.item.price &&
          food_items[i].category == widget.item.category) {
        food_items.removeAt(i);
        widget.resetstate();
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 10.0,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset('assets/pizza.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 9,
                      child: Text(
                        "Food Name:${widget.item.food}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text("Price:Rs ${widget.item.price}"),
                    SizedBox(height: 5.0),
                    Container(
                        width: MediaQuery.of(context).size.width / 6,
                        child: Text("Category:${widget.item.category}")),
                    Container(child: Text("Quantity:${widget.item.quantity}"))
                  ],
                ),
              ),
              SizedBox(width: 20.0),
              Container(
                width: MediaQuery.of(context).size.width / 10,
                //padding: EdgeInsets.all(8.0),
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      if (widget.icons == Icons.add) {
                        addfooditem(context);
                      } else if (widget.icons == Icons.remove) {
                        removefooditem(context);
                      }
                    },
                    child: Icon(widget.icons, color: Colors.white)),
              )
            ]));
  }
}
