import 'dart:convert';
import 'package:flutter_stripe_payments/models/klijent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

Future<Klijent> getKlijentById() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int KlijentID = sharedPreferences.get('klijentId');
  String username = sharedPreferences.getString('Username');
  String password = sharedPreferences.getString('Password');
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  final response =
      await http.get(Uri.parse('$url/api/Klijent/$KlijentID'),headers: {'authorization': basicAuth});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Klijent.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}




