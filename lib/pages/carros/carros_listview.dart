import 'package:carros/pages/carros/carro_page.dart';
import 'package:carros/pages/carros/carros_bloc.dart';
import 'package:carros/pages/text_error.dart';
import 'package:carros/util/nav.dart';
import 'package:flutter/material.dart';

import 'carros.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView({@required this.tipo});

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carros> carros;
  //final _streamController = StreamController<List<Carros>>();
  @override
  bool get wantKeepAlive => true;
  final _bloc = CarrosBloc();
  @override
  void initState() {
    super.initState();
    _bloc.loadData(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextError("Erro ao buscar lista de carros");
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Carros> carros = snapshot.data;
          return _listView(carros);
        });
  }

  Container _listView(List<Carros> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount:
            carros != null ? carros.length : 0, // contando registros/ tamanho
        itemBuilder: (context, index) {
          Carros c = carros[index]; // instanciando builder
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(c.urlFoto ??
                        "https://cidadedamusica0.webnode.com/_files/200000043-38fd039f65/450/madonna-baixar-musica-download-gratis.jpg"),
                  ),
                  Text(
                    c.nome ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    c.descricao ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      children: <Widget>[
                        TextButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(c),
                        ),
                        TextButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carros c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
