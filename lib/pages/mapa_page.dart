import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  
  Completer<GoogleMapController> _controller = Completer();
  MapType typeMap = MapType.normal;
  
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50
    );

    //Marcadores

    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-l'),
      position: scan.getLatLng()
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50
                  )
                )
              );
            }
          ),
        ],
      ),
      body: GoogleMap(
        mapType: typeMap,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: (){
          
          setState(() {
            typeMap = typeMap == MapType.normal?typeMap = MapType.satellite:typeMap = MapType.normal;
          });
        },
      ),
    );
  }
}