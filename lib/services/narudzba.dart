
import 'dart:convert';
import 'package:flutter_stripe_payments/models/narudzba.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

Future<List<Narudzba>> getAllOrder() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int KlijentId = sharedPreferences.get('klijentId');
  String username = sharedPreferences.getString('Username');
  String password = sharedPreferences.getString('Password');
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  var address =
      "$url/api/Narudzba/GetByKlijent/$KlijentId";
  final response = await http.get(Uri.parse(Uri.encodeFull(address)),headers: {'authorization': basicAuth});
    
  var body = json.decode(response.body) as List<Object>;

  return body.map((p) => Narudzba.fromJson(p)).toList();
}
  
