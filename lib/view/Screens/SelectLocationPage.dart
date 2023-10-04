import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/PlaceApiProvider.dart';
import 'package:new_projecct/Utils/Suggestion.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:new_projecct/view/Widgets/AddressSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});
  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}
class _SelectLocationPageState extends State<SelectLocationPage> {
  DeliveryLocationController controller =Get.put(DeliveryLocationController());
  String _currentAddress="";
  Position? _currentPosition;
  var latitude='';
  var longitude='';
  late  Future<List<Suggestion>> futureAlbum;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
    _handleLocationPermission(context);
    _getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
        title: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select Location",
                    style: TextStyle(
                      color: AppColors.whiteColors,
                      fontSize: AppSizeClass.maxSize20,
                      fontWeight: FontWeight.w500,

                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: TextField(
                  controller: controller.selectLocationController,
                  onTap: () async {
                    showSearch(
                      context: context,
                      delegate: AddressSearch(),
                    );
                  },
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.home,
                        color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                      ),
                    ),
                    hintText: "Search any location .....",
                    border: InputBorder.none,

                    contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                  ),
                ),
              ),
              Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async{
                            Navigator.pushNamed(context,RouteNames.delivery_screen,arguments: {
                              "page_flag":"1"
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Expanded(child:  Row(
                               children: [
                                 Icon(
                                   Icons.location_searching,
                                   size: AppSizeClass.maxSize25,
                                   color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR) ,
                                 ),
                               Expanded(child:   Container(
                                 margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisSize: MainAxisSize.min,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Text("Use current location",style: TextStyle(
                                         color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                         fontSize: AppSizeClass.maxSize15,
                                         fontWeight: FontWeight.bold,

                                     ),),
                                     Text(_currentAddress.toString(),style: TextStyle(
                                         color: GradientHelper.getColorFromHex(AppColors.Red_drak_COLOR),
                                         fontSize: AppSizeClass.maxSize12,
                                         fontWeight: FontWeight.bold,

                                     ),),

                                   ],
                                 ),
                               ))

                               ],
                             ),),
                              IconButton(
                                  onPressed: () async{
                                    Navigator.pushNamed(context,RouteNames.delivery_screen,arguments: {
                                      "page_flag":"1"
                                    });
                                  },
                                  icon: Icon(Icons.arrow_forward_ios,
                                    size: AppSizeClass.maxSize20,
                                    color: AppColors.greyColors ,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[500],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async{
                            Navigator.pushNamed(context,RouteNames.delivery_screen,arguments: {
                              "page_flag":"2"
                            });
                            },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.add,size: AppSizeClass.maxSize25,
                                    color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR) ,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Add location",style: TextStyle(
                                            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                            fontSize: AppSizeClass.maxSize15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "NotoSerif"
                                        ),),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              IconButton(
                                  onPressed: () async{

                                  },
                                  icon: Icon(Icons.arrow_forward_ios,
                                    size: AppSizeClass.maxSize20,
                                    color: AppColors.greyColors ,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      controller.latitude.value=_currentPosition!.latitude.toString();
      controller.longitude.value=_currentPosition!.longitude.toString();
      Placemark place = placemarks[0];
      print("address"+place.toString());
      setState(() {
        _currentAddress= '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        controller.selectLocation(_currentAddress!);
        prefs.setString("currentLocation", _currentAddress);
        controller.addressController.value=_currentAddress!;

      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void getValue() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentAddress= prefs.getString("currentLocation")!;
  }
}
