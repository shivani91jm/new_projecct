import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Utils/CommnUtils.dart';
import 'package:new_projecct/controller/AllOrdersControllers.dart';
import 'package:new_projecct/controller/CheckOutController.dart';

class TextClover extends StatefulWidget {
  const TextClover({super.key});

  @override
  State<TextClover> createState() => _TextCloverState();
}

class _TextCloverState extends State<TextClover> {
  AllOrdersController controller=Get.put(AllOrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: ElevatedButton(
        onPressed: () {
      // Call the function to make a payment
      makePayment();
    },
    child: Text(CommonUtilsClass.removeHtmlTags(controller.text)),
    ),)
    );
  }
  Future<void> makePayment() async {
    final String cloverApiKey = 'ad02ee1d-b00d-34db-0c06-d2b48e79e1de'; // Replace with your Clover API key
    final String paymentEndpoint = 'https://palrancho.co/v3/payments'; // Replace with the actual Clover API endpoint for payments

    final Map<String, dynamic> paymentData = {
      'amount': 1000, // Replace with the payment amount in cents
      'currency': 'USD', // Replace with the desired currency
      // Add other payment details as needed
    };

    final headers = {
      'Authorization': 'Bearer $cloverApiKey',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      final response = await http.post(
        Uri.parse(paymentEndpoint),
        headers: headers,
        body: jsonEncode(paymentData),
      );

      if (response.statusCode == 200) {
        // Payment was successful, handle the response as needed
        final jsonResponse = jsonDecode(response.body);
        print('Payment successful: $jsonResponse');
      } else {
        // Payment failed, handle the error
        print('Payment failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error: $e');
    }
  }

}
