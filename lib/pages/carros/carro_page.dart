import 'package:carros/pages/carros/carros.dart';
import 'package:carros/pages/carros/loripsum_api.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carros carros;
  CarroPage(this.carros);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  @override
  void initState() {
    super.initState();
    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "Editar", child: Text("Editar")),
                PopupMenuItem(value: "Excluir", child: Text("Excluir")),
                PopupMenuItem(
                    value: "Compartilhar", child: Text("Compartilhar")),
              ];
            },
          ),
        ],
        title: Text(
          widget.carros.nome,
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Image.network(widget.carros.urlFoto),
          _bloco1(),
          Divider(
            color: Colors.redAccent,
          ),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.carros.nome,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.carros.tipo,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.favorite, color: Colors.redAccent, size: 30),
                onPressed: _onClickFavorito),
            IconButton(
                icon: Icon(Icons.share, color: Colors.redAccent, size: 30),
                onPressed: _onClickShare),
          ],
        ),
      ],
    );
  }

  Column _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.carros.descricao, style: TextStyle(fontSize: 16)),
        StreamBuilder<String>(
            //future: LoripsumApi.getLoripsum(),
            stream: _loripsumApiBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Text(snapshot.data, style: TextStyle(fontSize: 16));
            }),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print(value);
        break;
      case "Excluir":
        print(value);
        break;
      case "Compartilhar":
        print(value);
        break;
      default:
    }
  }

  void _onClickFavorito() {}

  void _onClickShare() {}

  @override
  void dispose() {
    super.dispose();
    _loripsumApiBloc.dispose();
  }
}
