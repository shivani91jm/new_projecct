import 'package:new_projecct/Utils/AppContstansData.dart';

class BaseUrlsClass
{
    static const String BaseUrls="https://palrancho.co/";
    static const String locationUrls=BaseUrls+"location.php";
    static const String changeUrls="https://palrancho.co/wp-json/";
    static const String loginUrls=changeUrls+"jwt-auth/v1/token";
    static const String signUpUrls=changeUrls+"custom-registration-api/v1/register";
    static const String productCatUrls=changeUrls+"wc/v3/products?/categories";
    static const String productCatTitleUrls=changeUrls+"wc/v3/products?/categories";
}