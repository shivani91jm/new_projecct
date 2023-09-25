import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:new_projecct/view/Widgets/SetDeliveryLocation.dart';
class DeliveryLocationPage extends StatefulWidget {
  var data;
  DeliveryLocationPage({this.data});
  @override
  State<DeliveryLocationPage> createState() => _DeliveryLocationPageState();
}
class _DeliveryLocationPageState extends State<DeliveryLocationPage> {
  DeliveryLocationController controller=Get.put(DeliveryLocationController());
  late GoogleMapController mapController;
  var latitude='';
  var longitude='';
  CameraPosition? cameraPosition;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Completer<GoogleMapController> _googleMapController=Completer();
  late LatLng _defaultLatLong;
  late LatLng _draggedLatLong;
  var page_type="";
  @override
  void initState() {
    page_type=widget.data['page_flag'];
      init();
    super.initState();
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
          backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
          centerTitle: true,
          title: Text("Choose delivery location",style: TextStyle(
              color:AppColors.whiteColors,
              fontSize: AppSizeClass.maxSize20,
              fontWeight: FontWeight.bold,
              fontFamily: "NotoSerif"
          ),),
        ),
        bottomNavigationBar:Obx(() =>  Container(
            height: 200,
            child: SetDeliveryLocation(
              controller: controller,
              contexts: context,
              currentLocaion: controller.addressController.toString(),
              page_flag: page_type
              ,)
             )
        ),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor:  GradientHelper.getColorFromHex(AppColors.RED_COLOR),
          onPressed: (){
          _gotoCurrentPostion();
        },
        child:Icon(Icons.location_searching,color:  GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR)) ,),
      ),
    );
  }
  Widget _getMap(){
    return GoogleMap(
      mapType: MapType.normal,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller){
        if(!_googleMapController.isCompleted){
          _googleMapController.complete(controller);
        }
      },
      onCameraMove: (CameraPosition  cameraPosition){
        _draggedLatLong = cameraPosition.target;
      },
      onCameraIdle: (){
        _getAddress(_draggedLatLong);
      },
      initialCameraPosition: cameraPosition!,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,

    );
  }
  Widget _buildBody(){
    return Stack(
      children: [
        _getMap(),
        customMarkers(),
      ],
    );
  }
  void init() {
    _defaultLatLong=LatLng(26.299265689617403 ,-80.27699558507642);
    _draggedLatLong=_defaultLatLong;
    cameraPosition=CameraPosition(target: _defaultLatLong,
      zoom: 17.5
    );
    _gotoCurrentPostion();

  }
  Future _gotoCurrentPostion() async{
    Position currentPostion=await _determainUserCurrentPostion();
    _gotoSepPostion(LatLng(currentPostion.latitude, currentPostion.longitude));
  }
  Future _determainUserCurrentPostion() async{
    LocationPermission locationPermission;
    bool isLocationOn=await Geolocator.isLocationServiceEnabled();
    if(!isLocationOn)
      {
        CommonUtilsClass.toastMessage("User don't enable location Permission");
      }
    locationPermission =await Geolocator.checkPermission();
    if(locationPermission==LocationPermission.denied)
      {
        locationPermission=await Geolocator.requestPermission();
        CommonUtilsClass.toastMessage("user denied location permission");
      }
    if(locationPermission==LocationPermission.deniedForever)
      {
        CommonUtilsClass.toastMessage("user denied  permission forever");
      }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

 }
  Future _gotoSepPostion(LatLng postion) async{
    GoogleMapController mapController=  await  _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: postion,
      zoom: 17.5)
    ));
   await _getAddress(postion);
  }
  Future _getAddress(LatLng position) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    Placemark place=placemarks[0];
   String address = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode},${place.country}';
   print("address"+address.toString());
   setState(() {
      controller.addressController.value=address;
    });

  }
  Widget  customMarkers() {
    return Center(
      child: Image.asset(ImageUrls.marker_url, width: 40,),
    );
 }

}
