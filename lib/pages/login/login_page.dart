import 'dart:async';
import 'dart:ui';

import 'package:carros/api_response/api_response.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/pages/carros/home_page.dart';
import 'package:carros/util/alert.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusSenha = FocusNode();
  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) => setState(() {
          if (user != null) push(context, HomePage(), replace: true);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(height: 8),
            AppTextField(
              label: "Digite o login",
              hint: "e-mail",
              obscureText: false,
              controller: _tLogin,
              validator: _validadeLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              border: OutlineInputBorder(),
              nextFocus: _focusSenha,
              hintStyle: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            AppTextField(
              label: "Senha",
              hint: "senha",
              obscureText: true,
              controller: _tSenha,
              validator: _validateSenha,
              focusNode: _focusSenha,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            StreamBuilder<bool>(
                stream: _bloc.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return AppButton(
                    text: "Login",
                    function: _onClickLogin,
                    showProgress: snapshot.data,
                  );
                }),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    if (_formKey.currentState.validate()) {
      String login = _tLogin.text;
      String senha = _tSenha.text;

      ApiResponse response = await _bloc.login(login: login, senha: senha);

      if (response.ok) {
        Usuario user = response.objeto;
        print(user);
        push(context, HomePage());
      } else {
        print(response.msg);
        alert(context, response.msg);
      }
    }
  }

  String _validadeLogin(String text) {
    if (text.isEmpty) {
      return "digite o login";
    } else {
      return null;
    }
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "digite a senha";
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
