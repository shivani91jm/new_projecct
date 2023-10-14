import 'package:new_projecct/Utils/AppContstansData.dart';

class BaseUrlsClass
{
    static const String BaseUrls="https://palrancho.co/";
    static const String locationUrls=BaseUrls+"location.php";
    static const String changeUrls="https://palrancho.co/wp-json/";
    static const String loginUrls="/wp-json/jwt-auth/v1/token";
    static const String signUpUrls="/wp-json/custom-registration-api/v1/register";
    static const String updateprofileUrls="/update_user.php";
    static const String productCatUrls="/wp-json/wc/v3/products?categories=";
    static const String productCatTitleUrls="/wp-json/wc/v3/products?/categories";
    static const String allorderByUserUrls="/order_data.php?user_id=";
    static const String contactusUrls="/wp-json/custom-contact-form/v1/submit?";
    static const String changePasswordUrls="/wp-json/custom/v1/update-password?";
    static const String catProdUrls="/wp-json/custom-woocommerce/v1/categories-products";
}