import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated( GoogleMapController googleMapController ){
    _controller.complete( googleMapController );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("FastMap"),),
    body: Container(
      child: GoogleMap(
        mapType: MapType.normal, //PODEMOS MUDAR O TIPO DE MAPA AQUI
        //mapType: MapType.none, //PODEMOS MUDAR O TIPO DE MAPA AQUI
        //mapType: MapType.hybrid, //PODEMOS MUDAR O TIPO DE MAPA AQUI
        //mapType: MapType.satellite, //PODEMOS MUDAR O TIPO DE MAPA AQUI

        //-22.255513, -45.699865
        initialCameraPosition: CameraPosition(
            target: LatLng(-22.255513, -45.699865),
          zoom: 16 //MUDANÇA DE ZOOM NO MAPA
        ),
        onMapCreated: _onMapCreated,
      ),
    ),
    );
  }
}
