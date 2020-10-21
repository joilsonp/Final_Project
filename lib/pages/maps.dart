import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  final LatLng _center = const LatLng(-5.111154, -42.770134);

  // List<Marker> allMarkers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void checkLocation() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      PermissionStatus permissionStatus = await Permission.location.request();
    }
  }

  void _add(double lat, double long, titulo, subtitulo) {
    var adicionador = new Random();
    Marker marker = Marker(
        markerId: MarkerId('$adicionador'),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: titulo, snippet: subtitulo));
    setState(() {
      markers.add(marker);
    });
  }

  initState() {
    super.initState();
    checkLocation();
    _add(-5.110678, -42.752907, 'Lucas Peres', '-5.110678, -42.752907');
    _add(-5.092243, -42.776423, 'Nilda Maria', '-5.092243, -42.776423');
    _add(-5.132561, -42.784980, 'Nilton Soares', '-5.132561, -42.784980');
    _add(-5.117011, -42.790680, 'Paula Rodrigues', '-5.117011, -42.790680');
    _add(-5.098740, -42.786176, 'Kaio Jorge', '-5.098740, -42.786176');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Mapas', style: TextStyle(color: Colors.green, fontSize: 30)),
        backgroundColor: Colors.black,
      ),
      body: GoogleMap(
        //markers: Set<Marker>.of(),
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 13),
        myLocationEnabled: true,
        markers: markers,
      ),
    );
  }
}
