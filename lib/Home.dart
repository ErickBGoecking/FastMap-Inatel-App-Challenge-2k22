import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _posicaoCamera = CameraPosition(
      target: LatLng(-22.256959, -45.696820),
      zoom: 19
  );

  Set<Marker> _marcadores = {};

  _onMapCreated( GoogleMapController googleMapController ){
    _controller.complete( googleMapController );
  }

  _movimentarCamera() async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        _posicaoCamera
      )
    );

  }

  _carregarMarcadores(){

    Set<Marker> marcadoresLocal = {};

    Marker marcadorInatel = Marker(
        markerId: MarkerId("Inatel"),
        position: LatLng(-22.257056, -45.696612),
      infoWindow: InfoWindow(
        title: "Inatel"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueMagenta
      ),
      onTap: (){
        print("Inatel clicado!!");
      }
      //rotation: 45
    );

    Marker marcadorGoianos = Marker(
        markerId: MarkerId("Goianos"),
        position: LatLng(-22.255148, -45.697823),
      infoWindow: InfoWindow(
          title: "Goianos"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue
      ),
        onTap: (){
          print("Goianos!!");
        }
    );

    marcadoresLocal.add( marcadorInatel );
    marcadoresLocal.add( marcadorGoianos );

    setState(() {
      _marcadores = marcadoresLocal;
    });
  }

  _recuperarLocalizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    setState(() {
      _posicaoCamera = CameraPosition(
          target: LatLng (position.latitude, position.longitude),
              zoom: 17
      );
      _movimentarCamera();
    });

    //-22.259653, -45.702384
    //-22.259653, -45.702384

    //print("Localização Atual: " + position.toString());
  }

  @override
  void initState() {
    super.initState();
    //_carregarMarcadores();
    _recuperarLocalizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('FastMap'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: _movimentarCamera
      ),
      body: Container(
        child: GoogleMap(
            mapType: MapType.normal,
            //mapType: MapType.hybrid,
            //mapType: MapType.none,
            //mapType: MapType.satellite,
            //mapType: MapType.terrain,
            //-23.562436, -46.655005
            initialCameraPosition: _posicaoCamera  ,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            //markers: _marcadores,
        ),
      ),
    );
  }
}
