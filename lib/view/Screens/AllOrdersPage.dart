import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:new_projecct/controller/AllOrdersControllers.dart';
class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({super.key});

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  AllOrdersController controller=Get.put(AllOrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      body: SingleChildScrollView(
          child: ListView.builder(itemBuilder: itemBuilder),
      ),
    );
  }
}
