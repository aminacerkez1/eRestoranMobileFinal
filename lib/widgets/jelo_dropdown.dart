import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe_payments/global_url.dart';
import 'package:flutter_stripe_payments/models/jelo.dart';
import 'package:flutter_stripe_payments/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JeloDropdown extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<JeloDropdown> {
  String _mySelection;

  final String address = "$url/api/Jelo";

  List data = List(); //edited line

  Future<Jelo> getSWData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String username = sharedPreferences.getString('Username');
  String password = sharedPreferences.getString('Password');
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var res = await http.get(Uri.parse(Uri.encodeFull(address)),headers: {'authorization': basicAuth});
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    print(resBody);
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: new DropdownButtonFormField(
         validator: (value) => value == null
                    ? 'Odaberi jelo' : null,
                     decoration: InputDecoration(
                       enabledBorder: UnderlineInputBorder(      
                         borderSide: BorderSide(color:      
                       Colors.red))),
        isExpanded: true,
        hint: Text(
          'Odaberi jelo',
          style: TextStyle(
            fontFamily: 'RobotoMedium',
            fontSize: SizeConfig.safeBlockHorizontal * 3,
            color: Colors.black,
          ),
        ),
        items: data.map((item) {
          return new DropdownMenuItem(
            child: new Text(
              item['naziv'],
              style: TextStyle(fontSize: 13),
            ),
            value: item['jeloId'].toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _mySelection = newVal;
            for (int i = 0; i < data.length; i++) {
              if (data[i]['jeloId'].toString() == _mySelection) {
                jeloCijena = data[i]['cijena'];
                
              }
            }
            jeloId_global = int.parse(_mySelection);
          });
        },
        value: _mySelection,
      ),
    );
  }
}
