import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:new_projecct/view/Widgets/SetDeliveryLocation.dart';
class DeliveryLocationPage extends StatefulWidget {
  @override
  State<DeliveryLocationPage> createState() => _DeliveryLocationPageState();
}

class _DeliveryLocationPageState extends State<DeliveryLocationPage> {
  DeliveryLocationController controller=Get.put(DeliveryLocationController());
  static final LatLng _kMapCenter = LatLng(26.4474, 80.3300);
  late GoogleMapController mapController;
  var latitude='';
  var longitude='';
  final Set<Marker> _markers = {};
  String? _currentAddress;
  Position? _currentPosition;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleLocationPermission(context);
    _getCurrentPosition();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Choose delivery location",style: TextStyle(
              color:AppColors.blackColors,
              fontSize: AppSizeClass.maxSize20,
              fontWeight: FontWeight.bold,
              fontFamily: "NotoSerif"
          ),),
        ),
        bottomNavigationBar: Container(
          height: 200,
            child: SetDeliveryLocation(controller: controller, contexts: context, currentLocaion: controller.addressController.toString(),)),
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition:  CameraPosition(
            target: LatLng(26.299265689617403 ,-80.27699558507642),
            zoom: 16.0,
          ),
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          markers: Set<Marker>.from([
            Marker(
              markerId: MarkerId("currentLocation"),
              draggable: true,
              onDragEnd: (value) {},
              position: LatLng(26.299265689617403 ,-80.27699558507642),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          ]),
        ),

      ),
    );
  }
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);

    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      controller.latitude.value=_currentPosition!.latitude.toString();
      controller.longitude.value=_currentPosition!.longitude.toString();
      Placemark place = placemarks[0];
      print("address"+place.toString());
      setState(() {
        controller.addressController.value = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        print("address"+_currentAddress.toString());
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

}
