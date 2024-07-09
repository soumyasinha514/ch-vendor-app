import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class WebViewScreen extends StatelessWidget {
  final String assetPath;

  const WebViewScreen({super.key,required this.assetPath});

  @override
  Widget build(BuildContext context) {

     Future<String> loadHtmlFromAssets() async {
    return await rootBundle.loadString(assetPath);
  }

    return Scaffold(
      appBar: AppBar(
        title:const Text('Terms and Conditions'),
      ),
      body: FutureBuilder<String>(
        future: loadHtmlFromAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final controller = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(Color.fromARGB(192, 244, 238, 238))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onNavigationRequest: (NavigationRequest request) {
                    return NavigationDecision.navigate;
                  },
                ),
              )
              
              ..loadRequest(Uri.dataFromString(snapshot.data!,
                  mimeType: 'text/html',
                  encoding: Encoding.getByName('utf-8')));

            return WebViewWidget(
              controller: controller,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

 
}
