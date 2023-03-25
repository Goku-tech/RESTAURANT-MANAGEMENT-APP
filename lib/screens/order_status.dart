import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_app/custom_classes/form_fields.dart';
import 'package:dbms_app/screens/add_user.dart';
import 'package:dbms_app/screens/admin.dart';
import 'package:dbms_app/screens/cashier.dart';
import 'package:dbms_app/screens/cook.dart';
import 'package:dbms_app/screens/addorder.dart';
import 'package:dbms_app/screens/menu.dart';
import 'package:dbms_app/screens/myorders.dart';
import 'package:dbms_app/screens/new_order.dart';
import 'package:dbms_app/screens/orders_page.dart';
import 'package:dbms_app/screens/waiter.dart';
import 'package:dbms_app/services/authentication/authenticate.dart';
import 'package:dbms_app/services/crud/database.dart';
import 'package:dbms_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:dbms_app/global.dart';

class order_status extends StatefulWidget {
  @override
  State<order_status> createState() => orderstatusState();
}

class orderstatusState extends State<order_status> {
  String orderID = '';
  String cashier_status = '';
  String cashier_username = '';
  String cook_status = '';
  String cook_Username = '';
  late List<Map<String, dynamic>> items;
  String last_updated = '';
  String paymentstatus = '';
  String table_no = '';
  String waiter_status = '';
  String waiter_username = '';
  String TotalAmount = '';

  late List<dynamic> order_details;
  String error = '';

  void initialize_variable(List<dynamic> order_details) async {
    orderID = order_details[0]['orderid'];
    cashier_status = order_details[0]['cashierStatus'];
    cashier_username = order_details[0]['cashierUsername'];
    cook_status = order_details[0]['cookStatus'];
    cook_Username = order_details[0]['cookUsername'];
    last_updated = order_details[0]['lastUpdatedAt'];
    paymentstatus = order_details[0]['paymentStatus'];
    table_no = order_details[0]['tableNumber'];
    waiter_status = order_details[0]['waiterStatus'];
    waiter_username = order_details[0]['waiterUsername'];
    TotalAmount = order_details[1];
  }

  List<String> screens = ["Home", "My Orders", "Menu", "Orders", "Log Out"];

  void initState() {
    if (role == "Waiter") {
      screens.insert(4, "New Order");
    }
  }

  Widget find_role() {
    if (role == "Admin") {
      return admin();
    } else if (role == "Waiter") {
      return waiter();
    } else if (role == "Cashier") {
      return cashier();
    } else if (role == "Cook") {
      return cook();
    }

    return waiter();
  }

  void find_screen(String page) {
    Widget defaultpage;
    defaultpage = find_role();
    Widget current_page = waiter();

    if (page == "Home") {
      current_page = defaultpage;
    }

    if (page == "My Orders") {
      current_page = myorders();
    } else if (page == "Menu") {
      current_page = menu();
    } else if (page == "Add Order") {
      current_page = addorder();
    } else if (page == "Orders") {
      current_page = orders();
    } else if (page == "New Order") {
      current_page = neworder();
    } else if (page == "Add User") {
      current_page = adduser();
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => wrapper(
                default_page: defaultpage, current_page: current_page)));
  }

  void logout(BuildContext context) async {
    bool is_logged_out = await auth().signout();
    if (is_logged_out == true) {
      Navigator.pushReplacementNamed(context, "/login");
      food_items.clear();
      role = "Waiter";
      name = '';
    } else {
      print("Logout Unsuccesful");
    }
  }

  void get_items(BuildContext context) async {
    database data = database();

    List<dynamic> items = (await data.getitem(orderID)).toList();

    Navigator.pushNamed(context, '/view_items', arguments: items);
  }

  void update_status(BuildContext context) async {
    String status = (await Navigator.pushNamed(context, '/status')).toString();

    if (role == "Waiter") {
      waiter_status = status;
    } else if (role == "Cook") {
      cook_status = status;
    } else if (role == "Cashier") {
      cashier_status = status;
    }

    print(status);
  }

  void update_order_status(BuildContext context) async {
    String status = "";
    database data = database();

    if (role == "Waiter") {
      status = waiter_status;
    } else if (role == "Cook") {
      status = cook_status;
    } else if (role == "Cashier") {
      status = cashier_status;
    }

    await data.updatestatus(orderID, status, role, name);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                wrapper(default_page: find_role(), current_page: find_role())));
  }

  @override
  Widget build(BuildContext context) {
    order_details = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    initialize_variable(order_details);

    final _key = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
        backgroundColor: Colors.red[500],
      ),
      drawer: Drawer(
          child: ListView.builder(
              itemCount: screens.length,
              itemBuilder: (((context, index) {
                return Column(
                  children: [
                    ListTile(
                      tileColor: Colors.red,
                      title: Text(screens[index],
                          style: TextStyle(color: Colors.white)),
                      onTap: () async {
                        if (screens[index] == "Log Out") {
                          logout(context);
                        } else {
                          find_screen(screens[index]);
                        }
                      },
                    ),
                    Divider(height: 10.0, thickness: 5.0, color: Colors.black)
                  ],
                );
              })))),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Card(
            margin: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 8.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Order",
                      style: TextStyle(color: Colors.black, fontSize: 30.0)),
                  SizedBox(height: 10.0),
                  Text("OrderID:", style: TextStyle(fontSize: 20.0)),
                  Card(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                          width: 200.0,
                          child: Text(orderID,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.0)))),
                  SizedBox(height: 10.0),
                  Text("Total Amount:", style: TextStyle(fontSize: 20.0)),
                  Card(
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                        width: 200.0,
                        child: Text(TotalAmount,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0))),
                  ),
                  SizedBox(height: 10.0),
                  Text("Waiter:${waiter_username}",
                      style: TextStyle(fontSize: 20.0)),
                  Card(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                        width: 200.0,
                        child: Text(waiter_status,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0)),
                      )),
                  SizedBox(height: 10.0),
                  Text("Cook:${cook_Username}",
                      style: TextStyle(fontSize: 20.0)),
                  Card(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                          width: 200.0,
                          child: Text(cook_status,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.0)))),
                  SizedBox(height: 10.0),
                  Text("Cashier:${cashier_username}",
                      style: TextStyle(fontSize: 20.0)),
                  Card(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                        width: 200.0,
                        child: Text(cashier_status,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0)),
                      )),
                  SizedBox(height: 10.0),
                  Text("Table Number:", style: TextStyle(fontSize: 20.0)),
                  Card(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                          width: 200.0,
                          child: Text(table_no,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.0)))),
                  SizedBox(height: 10.0),
                  Text("Last Update At:", style: TextStyle(fontSize: 20.0)),
                  Card(
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                          width: 200.0,
                          child: Text(last_updated,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.0)))),
                  ElevatedButton(
                      onPressed: () {
                        get_items(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[500]),
                          fixedSize: MaterialStateProperty.all(
                              const Size(150.0, 35.0))),
                      child: Text("View Items",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  ElevatedButton(
                      onPressed: () {
                        update_status(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[500]),
                          fixedSize: MaterialStateProperty.all(
                              const Size(150.0, 35.0))),
                      child: Text("Update ${role} Status",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  ElevatedButton(
                      onPressed: () async {
                        update_order_status(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[500]),
                          fixedSize: MaterialStateProperty.all(
                              const Size(150.0, 35.0))),
                      child: Text("Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
