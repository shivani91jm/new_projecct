import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/view/Widgets/CustomButton.dart';
import 'package:new_projecct/view/Widgets/DividerWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CheckOutPage extends StatefulWidget {
  var data;
   CheckOutPage({super.key,required this.data});
   @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String currentLocation="";
  var page_flag="1";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      bottomNavigationBar: location(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               SizedBox(
                height: 20,
              ),
               Text("ITEM(S) ADDED", style: TextStyle(
                  fontSize: AppSizeClass.maxSize20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSerif",
                  color:AppColors.greyColors,
                )),
              SizedBox(
                height: 20,
              ),
                Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                           CircleAvatar(
                             child:  Icon(Icons.add),
                           ),
                            Text("Add more items")
                          ],
                        ),
                      Align(
                        child: IconButton(onPressed: () {  }, icon: Icon(
                          Icons.ice_skating
                        ),

                        ),
                      )

                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget location() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,5.0,0.0,0.0),
                      child: Icon(Icons.location_on,
                          size: AppSizeClass.maxSize20,
                          color: AppColors.whiteColors),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,5.0,0.0,0.0),
                        child: Text(currentLocation,style: TextStyle(
                            color:AppColors.whiteColors,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizeClass.maxSize15
                        ),),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,5.0,0.0,0.0),
                    child: Text("change",style: TextStyle(
                        color:AppColors.whiteColors,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizeClass.maxSize15
                    ),),
                  ),
                )

              ],
            ),
          DividerWidgets(),
          if(page_flag=="1")...
            {
                 CustomButton(
                  onPressed: () {

                  }, title:'Select Address at next step',
                  colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                  isLoading: false)
            }
            else...
            {
               CustomButton(
                  onPressed: () {}, title:'Select Address at next step',
                  colors: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
                  isLoading: false)
            }
        ],
      ),
    );
 }
  void getLocationValue()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLocation=  prefs.getString('currentLocation')!;
  }


}
