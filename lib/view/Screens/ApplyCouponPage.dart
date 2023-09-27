import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/AppSize.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
class ApplyCoupon extends StatefulWidget {
  const ApplyCoupon({super.key});

  @override
  State<ApplyCoupon> createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Available Coupon",
           style: TextStyle(
            fontSize: AppSizeClass.maxSize20,
            fontWeight: FontWeight.bold,
            fontFamily: "NotoSerif",
            color: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
            ),
            )
          ]
        ),
      ),
    );
  }
}
