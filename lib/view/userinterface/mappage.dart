import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertaskkssmart/view/userinterface/myproject.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({key, required this.latitude, required this.longitude})
      : super(key: key);
  var latitude;
  var longitude;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var initialCameraPosition;
  var mapController;
  Set<Marker> markers = {};

  // CameraPosition _kGooglePlex = const CameraPosition(
  //   target: LatLng(-37.3159, 81.1496),
  //   zoom: 14.4746,
  // );

  @override
  void initState() {
    super.initState();

    geoLocator();
    _determinePosition();
    // TODO: implement initSt  super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    var _center = LatLng(
      double.parse(widget.latitude),
      double.parse(widget.longitude),
    );
    initialCameraPosition = CameraPosition(
        target: LatLng(
            double.parse(widget.latitude), double.parse(widget.longitude)),
        zoom: 14.0);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyProject()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MyProject()));
              },
              icon: const Icon(Icons.arrow_back_ios_sharp)),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            buildingsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 5.0,
            ),
            onMapCreated: _onMapCreated,
            markers: markers,
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
    }

    return await Geolocator.getCurrentPosition();
  }

  geoLocator() async {
    Geolocator.getCurrentPosition().then((value) async {
      setState(() {
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      // getAddress(lat: value.latitude, long: value.longitude);
      setState(() {
        var marker = Marker(
            visible: true,
            icon: BitmapDescriptor.defaultMarker,
            markerId: const MarkerId("marker"),
            position: LatLng(
                double.parse(widget.latitude), double.parse(widget.longitude)));
        markers.add(marker);
      });
    });
  }
}
