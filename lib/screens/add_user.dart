import 'package:dbms_app/custom_classes/decorations.dart';
import 'package:dbms_app/custom_classes/form_fields.dart';
import 'package:dbms_app/screens/admin.dart';
import 'package:dbms_app/screens/waiter.dart';
import 'package:dbms_app/services/authentication/authenticate.dart';
import 'package:dbms_app/services/crud/database.dart';
import 'package:dbms_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

class adduser extends StatefulWidget {
  @override
  State<adduser> createState() => adduserState();
}

class adduserState extends State<adduser> {
  String Name = '';
  String Password = '';
  String Username = '';
  String Email = '';
  String Phone = '';
  String role = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    String? userid;

    void set_credential(String type, String data) {
      if (type == "Name") {
        Name = data;
      } else if (type == "Password") {
        Password = data;
      } else if (type == "Username") {
        Username = data;
      } else if (type == "Email") {
        Email = data;
      } else if (type == "Phone") {
        Phone = data;
      }
    }

    Future<void> createuser(String name, String password, String username,
        String email, String phone, String role) async {
      auth authenticate = auth();
      database userdata = database();
      userid = await authenticate.register_user(username, password);

      if (userid != null) {
        bool is_created = await userdata.createUser(
            id: userid.toString(),
            name: name,
            email: email,
            phone: phone,
            role: role,
            username: username);

        print(is_created);

        if (is_created == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      wrapper(default_page:admin(), current_page:admin())));
        }
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Form(
              key: _key,
              child: Card(
                margin: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 8.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Add User",
                        style: TextStyle(color: Colors.black, fontSize: 30.0)),
                    form_field("Name", set_credential),
                    form_field("Password", set_credential),
                    form_field("Username", set_credential),
                    form_field("Email", set_credential),
                    form_field("Phone", set_credential),
                    Text(
                      "Select Role",
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          role = (await Navigator.pushNamed(context, "/role"))
                              .toString();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[500]),
                            fixedSize: MaterialStateProperty.all(
                                const Size(150.0, 35.0))),
                        child: Text("Select Role",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate() == true) {
                            if (role != '') {
                              createuser(
                                  Name, Password, Username, Email, Phone, role);
                            }
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
                        child: Text("Confirm",
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
