import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //completer is an object that allows you to generate future object and complete them later with a value or error.
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(23.056157314485358, 72.50391881251721);
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    setState(() {
      // this is an initial marker of array.
      // final marker =  Marker(
      //   draggable: true,
      //   markerId: MarkerId("clicked"),
      //   position: LatLng(23.056157314485358, 72.50391881251721),
      // );
      // _markers["clicked"] = marker;
      // print(_markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onTap: (LatLng latLng) {
            final lat = latLng.latitude;
            final long = latLng.longitude;
            print(lat);
            print(long);
            setState(() {
              // this location is stored in an array, by taking the marker id, this marker will replace the initial marker in an array
              final marker = Marker(
                draggable: true,
                infoWindow: InfoWindow(
                  title: lat.toString(),
                  snippet: long.toString(),
                ),
                markerId: const MarkerId("clicked"),
                position: LatLng(lat, long),
              );
              _markers["clicked"] = marker;
              print(_markers);
            });
            //getting coordinates of a location on tap
/*            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          lat.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(long.toString(),
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  );
                });*/
          },
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
