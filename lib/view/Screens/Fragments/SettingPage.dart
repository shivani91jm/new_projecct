import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_projecct/Routes/RoutesNames.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppContstansData.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/DialogUtils.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/view/Widgets/CoustomAppBar.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final double coverHeight=230;
  final double circleHeight=140;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // You can set it back to the default color
    ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
    ));
  }
  @override
  Widget build(BuildContext context) {
    final top =coverHeight-circleHeight/2;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //---------------------- profile and header  ------------------
            CustomAppBar(text: "",
              height: coverHeight,
              flag: false,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(2,10,2,2),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-----------------------your profile----------
                    GestureDetector(
                      onTap: ()async{
                        Navigator.pushNamed(context,RouteNames.userProfile_screen);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.blue, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("Your Profile ", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{
                                        Navigator.pushNamed(context,RouteNames.userProfile_screen);
                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),

                  //--------------------your order ------------------
                    GestureDetector(
                      onTap: ()async{
                        Navigator.pushNamed(context,RouteNames.allOrders_screen);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.pink, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("Your Orders ", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{
                                        Navigator.pushNamed(context,RouteNames.allOrders_screen);
                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                    //---------------------address book ----------------
                    GestureDetector(
                      onTap: ()async{
                        Navigator.pushNamed(context,RouteNames.complete_address_screen);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.green, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("Address Book ", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{
                                        Navigator.pushNamed(context,RouteNames.complete_address_screen);
                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                //-----------------shop location-------------------
                    GestureDetector(
                      onTap: ()async{
                        Navigator.pushNamed(context,RouteNames.location_screen);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.pink, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("Shop Location ", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{
                                        Navigator.pushNamed(context,RouteNames.location_screen);
                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),

                //----------------contact us ------------------------
                    GestureDetector(
                      onTap: ()async{
                        Navigator.pushNamed(context,RouteNames.contactus_screen);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.yellow, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("Contact Us", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{

                                        Navigator.pushNamed(context,RouteNames.contactus_screen);
                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),

                  //-----------------------change password -------------
                    GestureDetector(
                      onTap: ()async{
                        Navigator.pushNamed(context,RouteNames.changepassword_screen);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.purpleAccent, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("Change Password", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{

                                        Navigator.pushNamed(context,RouteNames.changepassword_screen);
                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),

    //------------------------------about us------------------------
                    GestureDetector(
                      onTap: ()async{
                        Navigator.pushNamed(context,RouteNames.aboutus_screen);
                        },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.deepOrange, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("About Us", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{

                                        Navigator.pushNamed(context,RouteNames.aboutus_screen);
                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                    //--------------------logout container --------------------------

                    GestureDetector(
                      onTap: ()async{

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var  email = prefs.getString('email')?? "";
                            if(email!="" && email!="null")
                            {
                              DialogUtils.showCustomDialog(context,
                                  title: AppConstentData.logout,
                                  okBtnText: AppConstentData.ok,
                                  cancelBtnText: AppConstentData.cancel,
                                  okBtnFunction: () async {
                                    GoogleSignIn _googleSignIn = GoogleSignIn();
                                    bool isSignedIn = await _googleSignIn.isSignedIn();
                                    _googleSignIn.signOut();
                                    Navigator.pop(context);

                                  });
                            }
                            else
                            {
                             dialogNoAccount();
                            }

                        },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: AppColors.green,
                        elevation: 3,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.cyan, width: 15)),
                            ),

                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,20.0,0,0),
                                  child: Text("Logout", style: TextStyle(
                                    fontSize: AppSizeClass.maxSize17,
                                    fontWeight: FontWeight.w600,

                                    color:GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: () async{

                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        var  email = prefs.getString('email')?? "";
                                        if(email!="" && email!="null")
                                        {
                                          DialogUtils.showCustomDialog(context,
                                              title: AppConstentData.logout,
                                              okBtnText: AppConstentData.ok,
                                              cancelBtnText: AppConstentData.cancel,
                                              okBtnFunction: () async {
                                                GoogleSignIn _googleSignIn = GoogleSignIn();
                                                bool isSignedIn = await _googleSignIn.isSignedIn();
                                                _googleSignIn.signOut();
                                                Navigator.pop(context);

                                              });
                                        }
                                        else
                                        {
                                          dialogNoAccount();
                                        }

                                      }, icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),

                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ) ,
              )
          ],
        ),
      ),
    );
  }
  Widget datacgfgh() {
    return CircleAvatar(
      radius: circleHeight/2,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(AppSizeClass.maxSize25)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(ImageUrls.google_url),
              ],
            ),
          )
      ),
    );
  }

  void dialogNoAccount() async {
    await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Align(alignment:Alignment.center,
          child: Row(
            children: [
              Container(
                child:  Image.asset(ImageUrls.logo_url),
                height: 40,
                width: 30,
              ),
              Text('Please Login or SingUp',
                style: TextStyle(
                  fontSize: AppSizeClass.maxSize17,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif",
                  color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                ),
              ),
            ],
          )),
      content: Container(
          height: 80,
          decoration: BoxDecoration(),
          child: Column(
            children: [

              SizedBox(
                height: 10,
              ),
              DividerWidgets(),
              SizedBox(
                height: 10,
              ),
              Text("Don't have an account... ",
                style: TextStyle(
                  fontSize: AppSizeClass.maxSize17,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif",
                  color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                ),

              ),
            ],
          )),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No',
                style: TextStyle(
                  fontSize: AppSizeClass.maxSize18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif",
                  color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RouteNames.login_screen);
              },
              child: Text('Yes',
                style: TextStyle(
                  fontSize: AppSizeClass.maxSize18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif",
                  color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                ),
              ),
            ),
          ],
        )
      ],
    ),
    );
  }
}
