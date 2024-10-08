import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class PayWebview extends StatefulWidget {
  String paymentUrl;
  PayWebview({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  State<PayWebview> createState() => _PayWebviewState();
}

class _PayWebviewState extends State<PayWebview> {
  double _progress = 0;
  late InAppWebViewController webView;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(
              widget.paymentUrl,
            )),
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                ),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                )),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(() {
                _progress = progress / 100;
              });
            },
          ),
          _progress < 1
              ? SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
