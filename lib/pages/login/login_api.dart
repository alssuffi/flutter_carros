import 'dart:convert';

import 'package:carros/api_response/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(
      {@required String login, @required String senha}) async {
    try {
      var url =
          Uri.parse('https://carros-springboot.herokuapp.com/api/v2/login');

      Map params = {"username": login, "password": senha};
      String sjson = json.encode(params);

      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.post(url, body: sjson, headers: headers);
      print("Response statusCode ${response.statusCode}");
      print("Response body: ${response.body}");
      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();
        return ApiResponse.ok(user);
      } else {
        return ApiResponse.error(mapResponse["error"]);
      }
    } catch (error, execption) {
      print("Erro no login >> $error >> $execption");
      return ApiResponse.error("Dispositivo sem rede ou autenticador ausente");
    }
  }
}
