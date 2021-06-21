import 'package:carros/pages/carros/carros.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  final Carros carro;
  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
          markers: Set.of(_getMarkers()),
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(target: latLng(), zoom: 17)),
    );
  }

  latLng() {
    return carro.latlng();
  }

  Iterable<Marker> _getMarkers() {
    return [
      Marker(
          markerId: MarkerId("1"),
          position: carro.latlng(),
          infoWindow:
              InfoWindow(title: carro.nome, snippet: "Fábica ${carro.nome}"),
          onTap: () {
            print("clicou na janela");
          }),
    ];
  }
}
