import 'dart:convert';
import 'package:flutter_stripe_payments/models/rezervacija.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

Future<List<Rezervacija>> getAllReservation() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int KlijentId = sharedPreferences.get('klijentId');

  String username = sharedPreferences.getString('Username');
  String password = sharedPreferences.getString('Password');
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);

  var address = "$url/api/Rezervacija/GetByKlijent/$KlijentId";
  final response = await http.get(Uri.parse(Uri.encodeFull(address)),headers: {'authorization': basicAuth});

  var body = json.decode(response.body) as List<Object>;

  return body.map((p) => Rezervacija.fromJson(p)).toList();
}
