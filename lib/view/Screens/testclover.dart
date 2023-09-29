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
  CheckOutController controller=Get.put(CheckOutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: ElevatedButton(
        onPressed: () {
      // Call the function to make a payment
      makePayment();
    },
    child: Text("hhgj"),
    ),)
    );
  }
  Future<void> makePayment() async {
    final String cloverApiKey = 'ad02ee1d-b00d-34db-0c06-d2b48e79e1de';
    final String paymentEndpoint = 'https://palrancho.co/v3/payments';

    final Map<String, dynamic> paymentData = {
      'amount': 1000,
      'currency': 'USD',
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

  Future<void> fetchOrderDetails(String orderId) async {
    final String url = 'https://apisandbox.dev.clover.com/v3/merchants/PPSP55WHHYYV1/orders/1';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer <YOUR_ACCESS_TOKEN>',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // Process the data
    } else {
      throw Exception('Failed to load order details');
    }
  }
  Future<void> createCloverOrder(String accessToken) async {
    final url = Uri.parse('https://api.clover.com/v3/merchants/PPSP55WHHYYV1/orders'); // Replace {merchant_id} with your merchant's ID.

    // Define the order details as a JSON payload
    final orderData = {
      "total": 1000, // Replace with the total amount of the order.
      "state": "open", // Order state (e.g., "open")
      // Add other order details here as needed.
    };

    // Make the HTTP POST request
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 2a88f2a3-1715-417e-c85d-1b8b38954d38',
      },
      body: json.encode(orderData),
    );

    if (response.statusCode == 201) {
      // Order created successfully
      print('Order created successfully');
    } else {
      // Handle the error
      print('Failed to create order. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }


}
