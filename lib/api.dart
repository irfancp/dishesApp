import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

class Api {
  Future<Autogenerated> getData() async {
    http.Response response = await http
        .get(Uri.parse("https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad"));
    if (response.statusCode == 200) {
      return Autogenerated.fromJson(jsonDecode(response.body));
    } else {
      return Autogenerated();
    }
  }
}
