import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:incident_reporter/array.dart';

class Map extends StatefulWidget {
  final LatLng? placeToGo;

  Map({this.placeToGo});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  Future<void> _getIntializeLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    await _controller.future;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Position position = await Geolocator.getCurrentPosition();
    // CameraPosition? currentLocation = CameraPosition(
    //   target: LatLng(position.latitude, position.longitude),
    //   zoom: 14.4746,
    // );

    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
  }

  static final CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(5.5965904, -0.2228927),
    zoom: 14.4746,
  );

  CameraPosition? _placeToGo;

  @override
  void initState() {
    super.initState();
    _getIntializeLocation();
    // _placeToGo = CameraPosition(
    //     bearing: 192.8334901395799,
    //     target: widget.placeToGo ?? LatLng(5.60506, -0.2276565),
    //     tilt: 59.440717697143555,
    //     zoom: 19.151926040649414);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: _defaultLocation,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(children: [
                CircleAvatar(
                  child: IconButton(
                    onPressed: () => _onShowDirectionPolice(),
                    icon: Icon(Icons.local_police_outlined),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () => _onShowDirectionfireService(),
                    icon: Icon(Icons.fire_extinguisher_outlined),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () => _onShowDirectionEcg(),
                    icon: Icon(Icons.electrical_services_outlined),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () => _onShowDirectionHospital(),
                    icon: Icon(Icons.local_hospital_outlined),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () => _onShowDirectionWater(),
                    icon: Icon(Icons.water),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   // onPressed: _goToPoliceStation,
      //   label: Text('To the Police Station!'),
      //   icon: Icon(Icons.local_police_outlined),
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onShowDirectionfireService() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var data in fireServiceList)
                    ListTile(
                      onTap: () async {
                        CameraPosition position = CameraPosition(
                            bearing: 0,
                            target: LatLng(data["lat"], data["log"]),
                            tilt: 0,
                            zoom: 19.151926040649414);
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(position));
                      },
                      title: Text("${data['name']}"),
                    ),
                ],
              ),
            ),
          );
        });
  }

  void _onShowDirectionEcg() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var data in EcgList)
                    ListTile(
                      onTap: () async {
                        CameraPosition position = CameraPosition(
                            bearing: 0,
                            target: LatLng(data["lat"], data["log"]),
                            tilt: 0,
                            zoom: 19.151926040649414);
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(position));
                      },
                      title: Text("${data['name']}"),
                    ),
                ],
              ),
            ),
          );
        });
  }

  void _onShowDirectionPolice() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var data in stationsList)
                    ListTile(
                      onTap: () async {
                        CameraPosition position = CameraPosition(
                            bearing: 0,
                            target: LatLng(data["lat"], data["log"]),
                            tilt: 0,
                            zoom: 19.151926040649414);
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(position));
                      },
                      title: Text("${data['name']}"),
                    ),
                ],
              ),
            ),
          );
        });
  }

  void _onShowDirectionHospital() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var data in HospitalList)
                    ListTile(
                      onTap: () async {
                        CameraPosition position = CameraPosition(
                            bearing: 0,
                            target: LatLng(data["lat"], data["log"]),
                            tilt: 0,
                            zoom: 19.151926040649414);
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(position));
                      },
                      title: Text("${data['name']}"),
                    ),
                ],
              ),
            ),
          );
        });
  }

  void _onShowDirectionWater() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var data in WaterList)
                    ListTile(
                      onTap: () async {
                        CameraPosition position = CameraPosition(
                            bearing: 0,
                            target: LatLng(data["lat"], data["log"]),
                            tilt: 0,
                            zoom: 19.151926040649414);
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(position));
                      },
                      title: Text("${data['name']}"),
                    ),
                ],
              ),
            ),
          );
        });
  }
  // Future<void> _goToPoliceStation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_placeToGo!));
  // }
}
