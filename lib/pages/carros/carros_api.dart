import 'package:carros/pages/carros/carro_dao.dart';
import 'package:carros/pages/carros/carros.dart';
import 'package:carros/pages/login/usuario.dart';
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
    final dao = CarroDAO();
    /*
    for (Carros c in carros) {
      dao.save(c);
    }
    */
    // igual for de cima
    carros.forEach(dao.save);
    return carros;
  }
}
