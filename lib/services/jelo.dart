import 'dart:convert';
import 'package:flutter_stripe_payments/models/jelo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

Future<List<Jelo>> getAllDish() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var address = "$url/api/Jelo";

  String username = sharedPreferences.getString('Username');
  String password = sharedPreferences.getString('Password');
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);
  final response = await http.get(Uri.parse(Uri.encodeFull(address)),headers: {'authorization': basicAuth});

  var body = json.decode(response.body) as List<Object>;

  return body.map((p) => Jelo.fromJson(p)).toList();
}
