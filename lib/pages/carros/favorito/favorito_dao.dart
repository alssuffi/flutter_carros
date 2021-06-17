import 'package:carros/pages/carros/favorito/favorito.dart';
import 'package:carros/util/sql/base_dao.dart';

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  // TODO: implement tableName
  String get tableName => "favoritos";

  @override
  Favorito fromJson(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }
}
