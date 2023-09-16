import 'package:get/get.dart';

class AboutUsController extends GetxController{
  var isLoading = true.obs;
  void onPageFinished(String url) {
    isLoading.value = false;
  }
  void onPaheStart(String url)
  {
    isLoading.value=true;
  }

}