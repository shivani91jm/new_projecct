import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';

class CommonUtilsClass {
  static toastMessage(String msg) {
    Fluttertoast.showToast(msg: msg,
      backgroundColor: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
      textColor: AppColors.whiteColors,
      fontSize: AppSizeClass.maxSize14,
      toastLength: Toast.LENGTH_LONG,
    );

  }
 static String removeHtmlTags(String html) {
    String text = '';
    bool isInsideTag = false;

    for (int i = 0; i < html.length; i++) {
      if (html[i] == '<') {
        isInsideTag = true;
      } else if (html[i] == '>') {
        isInsideTag = false;
      } else if (!isInsideTag) {
        text += html[i];
      }
    }

    return text;
  }
  static CommonUtilsClass _instance = new CommonUtilsClass.internal();

  CommonUtilsClass.internal();

  factory CommonUtilsClass() => _instance;

}