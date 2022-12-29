import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({Key? key}) : super(key: key);

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {

  late final WebViewController _controller;



  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {

            // if (request!.contains("https://5taka.com/api/v2/bkash/success")) {
            //
            //   Navigator.push(context, MaterialPageRoute(builder: (_)=> BkashSuccessPage(
            //
            //   ) ));
            // } else if (page.contains("/bkash/fail")) {
            //   ToastComponent.showDialog("Payment cancelled", context,
            //       gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            //   Get.offAll(Home());
            //   return;
            // }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse('https://tajabajar.com/api/v2/bkash/begin/3361'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_willPopCallback ,

      child: Scaffold(

        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.offAll(HomeScreen());
          }, icon: Icon(Icons.arrow_back)),

          title: Text("order Screen"),

        ),
        body: WebViewWidget(

          controller: _controller,



        )
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Do you want to exit app?"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                },
                child: Text("Yes")),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(HomeScreen());
                },
                child: Text("No")),
          ],
        ));
    return false; // return true if the route to be popped
  }
}
