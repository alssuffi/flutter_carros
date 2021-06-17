import 'dart:async';

import 'package:carros/pages/carros/carros.dart';
import 'package:carros/util/sql/base_dao.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carros> {
  @override
  // TODO: implement tableName
  String get tableName => "carro";

  @override
  Carros fromJson(Map<String, dynamic> map) {
    // TODO: implement fromJson
    return Carros.fromMap(map);
  }

  Future<List<Carros>> findAllByTipo(String tipo) async {
    // final dbClient = await db;

    // final list = await dbClient
    //     .rawQuery('select * from $tableName where tipo =? ', [tipo]);

    // return list.map<Carros>((json) => fromJson(json)).toList();

    return query('select * from $tableName where tipo =? ', [tipo]);
  }
}
