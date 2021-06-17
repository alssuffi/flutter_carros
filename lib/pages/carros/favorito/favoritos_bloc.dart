import 'package:carros/pages/carros/carro_dao.dart';
import 'package:carros/pages/simple_bloc.dart';

import '../carros.dart';
import 'favorito_service.dart';

class FavoritosBloc extends SimpleBloc {
  loadData(String tipo) async {
    try {
      List<Carros> carros = await FavoritoService.getCarros(); // instanciando
      final dao = CarroDAO();
      /*
    for (Carros c in carros) {
      dao.save(c);
    }
    */
      // igual for de cima
      carros.forEach(dao.save);
      add(carros);
      return carros;
    } catch (e) {
      //print(e);
      addError(e);
    }
  }
}
