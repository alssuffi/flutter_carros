import 'dart:async';

import 'package:carros/api_response/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/pages/simple_bloc.dart';
import 'package:flutter/material.dart';

import 'login_api.dart';

class LoginBloc {
  final _streamController = StreamController<bool>();

  Stream<bool> get stream => _streamController.stream;

  Future<ApiResponse<Usuario>> login(
      {@required String login, @required String senha}) async {
    _streamController.add(true);
    ApiResponse response = await LoginApi.login(login: login, senha: senha);
    _streamController.add(false);
    return response;
  }

  void dispose() {
    _streamController.close();
  }
}
