import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/Utils/Urls/BaseUrlsClass.dart';
import 'package:new_projecct/model/LocationModel/LocationModelClass.dart';
import 'package:new_projecct/view/Widgets/NoInternetClass.dart';

class LocationController extends GetxController {
  RxList<Locations> locationList=<Locations>[].obs;
  Rx<Locations>? selectedLocationId=Locations().obs;
  RxBool loading=false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchLocationData();
  }
  @override
  void onReady() {
    super.onReady();
  }

  void fetchLocationData() async
  {
    loading.value=true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          var urls=BaseUrlsClass.locationUrls;
          print("url is location"+urls);
          final response = await http.get(Uri.parse(urls));
          if (response.statusCode == 200)
          {
              loading.value=false;
              LocationModelClass data =  LocationModelClass.fromJson(jsonDecode(response.body));
              if(data!=null)
              {
                locationList.value=data.locations!;
              }
              print("location lenth "+locationList.length.toString());
          }
          else if (response.statusCode == 500) {
            loading.value=false;
            LocationModelClass data=  LocationModelClass.fromJson(jsonDecode(response.body));
            print(""+data.toString());
            CommonUtilsClass.toastMessage("Server side Error");
          }
          else {
            loading.value=false;
            CommonUtilsClass.toastMessage("Server side Error");
            throw Exception('Failed to load album');
          }
      }

    } on SocketException catch(_) {
        loading.value=false;
        NoInternetClass(page: RouteNames.location_screen,);
        CommonUtilsClass.toastMessage("No Internet Connection....");
    }
  }

}