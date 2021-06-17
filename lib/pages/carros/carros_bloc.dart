import 'package:carros/pages/carros/carro_dao.dart';
import 'package:carros/pages/simple_bloc.dart';
import 'package:carros/util/netwoork.dart';

import 'carros.dart';
import 'carros_api.dart';

class CarrosBloc extends SimpleBloc {
  loadData(String tipo) async {
    try {
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        List<Carros> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }

      List<Carros> carros =
          await CarrosApi.getCarros(tipo: tipo); // instanciando
      final dao = CarroDAO();
      /*
    for (Carros c in carros) {
      dao.save(c);
    }
    */
      // igual for de cima
      carros.forEach(dao.save);
      add(carros);
    } catch (e) {
      //print(e);
      addError(e);
    }
  }
}
