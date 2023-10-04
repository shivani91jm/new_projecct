import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/Utils/PlaceApiProvider.dart';
import 'package:new_projecct/Utils/Suggestion.dart';
import 'package:new_projecct/controller/DeliveryLocationController.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddressSearch extends SearchDelegate<Suggestion>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () async{
          query = '';
        },
      )
    ];
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () async {
        query = '';
        //close(context, snapshot.data![index]);
        Navigator.of(context).pop();


      },
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return  Text("");
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: PlaceApiProvider.fetchSuggestions(query, "eng"),
      builder: (context, snapshot) => query == '' ? Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
            child: Text('Search Location....',
              style: TextStyle(
          fontSize: AppSizeClass.maxSize18,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColors

        ),)),) : snapshot.hasData
          ? ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Container(
            child: Row(
              children: [
                Icon(Icons.location_on,color: GradientHelper.getColorFromHex(AppColors.RED_COLOR)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*.7,
                      child: Text(snapshot.data![index].description.toString(),
                      style: TextStyle(
                        color: GradientHelper.getColorFromHex(AppColors.YellowDrak_COLOR),
                        fontSize: AppSizeClass.maxSize16,
                        fontWeight: FontWeight.w400
                      ),)),
                )
              ],
            ),
          ),
          onTap: () async {
            close(context, snapshot.data![index]);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('address',snapshot.data![index].description.toString());
            print("data"+snapshot.data![index].description.toString());
            DeliveryLocationController controller= Get.put(DeliveryLocationController());
            controller.selectLocationController.text=snapshot.data![index].description.toString();
          },
        ),
        itemCount: snapshot.data!.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Colors.grey[300],
          );
        },
      ) : Container(child: Text('Loading...',
          style: TextStyle(
              fontSize: AppSizeClass.maxSize18,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColors

          ))),
    );
  }

}
