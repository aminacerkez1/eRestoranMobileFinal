import 'dart:convert';
import 'package:flutter_stripe_payments/models/ocjena.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../global_url.dart';

Future<Ocjena> addStars(int ocjena, int jelo) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int KlijentId = sharedPreferences.get('klijentId');
  String username = sharedPreferences.getString('Username');
  String password = sharedPreferences.getString('Password');
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  final http.Response response = await http.post(
    Uri.parse('$url/api/Ocjena'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': basicAuth
    },
    body: jsonEncode(<String, String>{
      "KlijentId": "$KlijentId",
      "Ocjena1": "$ocjena",
      "JeloId": "$jelo"
    }),
  );
}
