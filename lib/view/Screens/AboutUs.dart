import 'package:flutter/material.dart';
import 'package:new_projecct/Utils/AppColors.dart';
import 'package:new_projecct/Utils/GradientHelper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  WebViewController? controller;
  //var loadingPercentage = 0;
  var _isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            setState(() {
            _isLoading=true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
             _isLoading=false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://palrancho.co/about/'));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GradientHelper.getColorFromHex(AppColors.RED_COLOR),
        ),
        body:   Stack(
          children: <Widget>[
            WebViewWidget(controller: controller!,),
            _isLoading ? Center(child: CircularProgressIndicator(
              color: GradientHelper.getColorFromHex(AppColors.Box_BG_COLOR),
            )) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
