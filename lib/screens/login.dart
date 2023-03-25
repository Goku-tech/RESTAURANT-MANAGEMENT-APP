import 'package:dbms_app/custom_classes/decorations.dart';
import 'package:dbms_app/custom_classes/form_fields.dart';
import 'package:dbms_app/screens/admin.dart';
import 'package:dbms_app/screens/cashier.dart';
import 'package:dbms_app/screens/cook.dart';
import 'package:dbms_app/global.dart';
import 'package:dbms_app/screens/waiter.dart';
import 'package:dbms_app/services/authentication/authenticate.dart';
import 'package:dbms_app/services/crud/database.dart';
import 'package:dbms_app/wrapper/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => loginState();
}

class loginState extends State<login> {
  String Email = '';
  String Password = '';
  String error = '';

  auth authenticate = auth();
  String? userid;

  @override
  Widget build(BuildContext context) {
    decorations decoration = decorations();

    Widget home_page = waiter();

    final _key = GlobalKey<FormState>();

    void set_credential(String type, String data) {
      if (type == "Username") {
        Email = data;
      } else {
        Password = data;
      }
    }

    Future<String> get_role(String userid) async {
      database user = database();
      String getrole = await user.getrole(userid);
      return getrole;
    }

    Future<String> get_name(String userid) async {
      database user = database();
      String getrole = await user.getname(userid);
      return getrole;
    }

    Future<void> validate_user(String Email, String Password) async {
      userid = await authenticate.signinwithemailandpassword(Email, Password);
      if (userid != null) {
        role = (await get_role(userid.toString())).toString();
        name = (await get_name(userid.toString())).toString();

        if (role == "Admin") {
          home_page = admin();
        } else if (role == "Waiter") {
          home_page = waiter();
        } else if (role == "Cook") {
          home_page = cook();
        } else if (role == "Cashier") {
          home_page = cashier();
        }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    wrapper(default_page: home_page, current_page: home_page)));
      } else {
        setState(() {
          error = "INVALID CREDENTIALS";
        });
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: decoration.login_decor(),
          child: Form(
            key: _key,
            child: Center(
              child: Card(
                margin: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0)),
                    SizedBox(height: 30.0),
                    form_field("Username", set_credential),
                    SizedBox(height: 10.0),
                    form_field("Password", set_credential),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate() == true) {
                            await validate_user(Email, Password);
                          } else {
                            setState(() {
                              error = "INVALID CREDENTIALS";
                            });
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[500]),
                            fixedSize: MaterialStateProperty.all(
                                const Size(150.0, 35.0))),
                        child: Text("Sign in",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    Text(error,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
