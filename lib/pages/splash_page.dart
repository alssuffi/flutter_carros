import 'package:carros/pages/carros/home_page.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/util/sql/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  //const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future futureB = Future.delayed(Duration(seconds: 3));
    // Inicializa o banco de dados
    Future futureA = DatabaseHelper.getInstance().db;

    Future<Usuario> futureC = Usuario.get();
    /*futureC.then((Usuario user) => setState(() {
          if (user != null) push(context, HomePage(), replace: true);
        }));
        */

    Future.wait([futureA, futureB, futureC]).then((List values) {
      print(values);
      Usuario user = values[2];
      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
