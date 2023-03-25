import 'package:dbms_app/screens/add_item.dart';
import 'package:dbms_app/screens/add_user.dart';
import 'package:dbms_app/screens/admin.dart';
import 'package:dbms_app/screens/cashier.dart';
import 'package:dbms_app/screens/cook.dart';
import 'package:dbms_app/screens/login.dart';
import 'package:dbms_app/screens/addorder.dart';
import 'package:dbms_app/screens/menu.dart';
import 'package:dbms_app/screens/myorders.dart';
import 'package:dbms_app/screens/new_order.dart';
import 'package:dbms_app/screens/order_status.dart';
import 'package:dbms_app/screens/orders_page.dart';
import 'package:dbms_app/screens/select_role.dart';
import 'package:dbms_app/screens/select_status.dart';
import 'package:dbms_app/screens/view_items.dart';
import 'package:dbms_app/screens/waiter.dart';
import 'package:dbms_app/wrapper/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dbms_app/global.dart';
import 'package:flutter/material.dart';

void main() async {
  food_items = [];
  role = "Waiter";
  name = '';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, routes: {
      "/": (context) => login(),
      "/login": (context) => login(),
      "/adduser": (context) => adduser(),
      "/waiter": (context) => waiter(),
      "/cook": (context) => cook(),
      "/cashier": (context) => cashier(),
      "/admin": (context) => admin(),
      "/role": (context) => selectrole(),
      "/status": (context) => status(),
      "/menu": (context) => addorder(),
      "/add_item": (context) => additem(),
      "/all_orders": (context) => orders(),
      "/my_orders": (context) => myorders(),
      "/order_status": (context) => order_status(),
      "/new_order": (context) => neworder(),
      "/view_items": (context) => viewitems()
    }),
  );
}
