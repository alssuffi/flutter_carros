import 'package:carros/pages/carros/carros.dart';
import 'package:carros/util/sql/entity.dart';

class Favorito extends Entity {
  int id;
  String nome;

  Favorito();
  Favorito.fromCarro(Carros c) {
    id = c.id;
    nome = c.nome;
  }

  Favorito.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  // QUANDO VC ESTA GRAVANDO OS DADOS.
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
