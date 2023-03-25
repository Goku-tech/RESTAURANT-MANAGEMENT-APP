import 'package:dbms_app/custom_classes/decorations.dart';
import 'package:flutter/material.dart';

class form_field extends StatelessWidget {
  String type;
  String data = '';
  decorations decoration = decorations();
  Function set_credential;

  form_field(this.type, this.set_credential);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            type,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
          SizedBox(height: 5.0),
          TextFormField(
              obscureText:type=="Password"?true:false,
              decoration: decoration.formDecor().copyWith(hintText: type),
              validator: (credential) =>
                  credential!.isEmpty ? "Invalid Credential" : null,
              onChanged: (credential) {
                data = credential;
                set_credential(type,data);
              },
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
