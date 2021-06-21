import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carros/carro_page.dart';
import 'package:carros/pages/text_error.dart';

import 'package:carros/util/nav.dart';

import 'package:flutter/material.dart';

import '../carros.dart';
import 'favoritos_bloc.dart';

class FavoritosListView extends StatefulWidget {
  @override
  _FavoritosListViewState createState() => _FavoritosListViewState();
}

class _FavoritosListViewState extends State<FavoritosListView>
    with AutomaticKeepAliveClientMixin<FavoritosListView> {
  List<Carros> carros;
  //final _streamController = StreamController<List<Carros>>();
  @override
  bool get wantKeepAlive => true;
  final _bloc = FavoritosBloc();
  final favoritosBloc = FavoritosBloc();
  @override
  void initState() {
    super.initState();
    // _bloc.loadData(widget.tipo);
    _bloc.loadData(null);
    print("FavoritosListView");
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
                    child: CachedNetworkImage(
                        imageUrl: c.urlFoto ??
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
