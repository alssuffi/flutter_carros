import 'package:carros/pages/simple_bloc.dart';

import 'carros.dart';
import 'carros_api.dart';

class CarrosBloc extends SimpleBloc {
  loadData(String tipo) async {
    try {
      List<Carros> carros =
          await CarrosApi.getCarros(tipo: tipo); // instanciando
      add(carros);
    } catch (e) {
      //print(e);
      addError(e);
    }
  }
}
