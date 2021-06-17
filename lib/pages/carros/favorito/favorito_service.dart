import 'package:carros/pages/carros/carro_dao.dart';
import 'package:carros/pages/carros/carros.dart';
import 'package:carros/pages/carros/favorito/favorito.dart';
import 'package:carros/pages/carros/favorito/favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carros c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final existe = await dao.exists(c.id);

    if (existe) {
      dao.delete(c.id);
      return false;
    } else {
      dao.save(f);
      return true;
    }
  }

  static Future<List<Carros>> getCarros() async {
    //  SELECT carro.*  from carro , favoritos where carro.id = favoritos.id
    List<Carros> carros = await CarroDAO().query(
        "SELECT carro.*  from carro , favoritos where carro.id = favoritos.id");
    return carros;
  }

  static Future<bool> isFavorito(Carros c) async {
    final dao = FavoritoDAO();
    bool exists = await dao.exists(c.id);
    return exists;
  }
}
