import 'package:carros/pages/carros/carros.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/api_response/api_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos"; // constante
  static final String esportivos = "esportivos"; // constante
  static final String luxo = "luxo"; // constante
}

class CarrosApi {
  static Future<List<Carros>> getCarros({@required String tipo}) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = Uri.parse(
        "https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo");
    var response = await http.get(url, headers: headers);
    print(url);

    List list = json.decode(response.body);

    final carros = list.map<Carros>((map) => Carros.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carros c) async {
    Usuario user = await Usuario.get();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };
    var url =
        Uri.parse("https://carros-springboot.herokuapp.com/api/v2/carros");
    print("POST> $url ");

    String json1 = c.toJson();

    var response = await http.post(url, body: json1, headers: headers);

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.body == null || response.body.isEmpty) {
      return ApiResponse.error("Não foi possivel salvar o carro");
    }

    if (response.statusCode == 201) {
      Map mapResponse = json.decode(response.body);

      Carros carro = Carros.fromMap(mapResponse);

      print("Novo carro: ${carro.id} ");

      return ApiResponse.ok(true);
    } else {
      Map mapResponse = json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    }
  }

  static Future<ApiResponse<bool>> delete(Carros c) async {
    Usuario user = await Usuario.get();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };
    var url = Uri.parse(
        "https://carros-springboot.herokuapp.com/api/v2/carros/${c.id}");
    print("DELETE > $url ");

    var response = await http.delete(url, headers: headers);

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.body == null || response.body.isEmpty) {
      return ApiResponse.error("Não foi possivel excluir o carro");
    }

    if (response.statusCode == 200) {
      print("Excluído carro: ${c.id} ");

      return ApiResponse.ok(true);
    } else {
      Map mapResponse = json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    }
  }
}
