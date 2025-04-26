import 'package:betappadmin/utills/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class StoreWebView extends StatefulWidget {
  var url;
  bool done;
  StoreWebView({required this.url,required this.done});
  @override
  StoreWebViewState createState() => StoreWebViewState();
}

class StoreWebViewState extends State<StoreWebView> {
  final GlobalKey webViewKey = GlobalKey();

  double progress = 0;
  final urlController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themecolor,
        appBar:widget.done==true? AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor:themecolor,

          automaticallyImplyLeading: false,
        ):null,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(children: <Widget>[
              Container(
                height: size.height * 0.87,
                width: size.width,
                child: WebView(
                  zoomEnabled: true,
          

                  initialUrl: widget.url,
                  gestureNavigationEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
              SizedBox(
                height: 120,
              )
            ]),
          ),
        ));
  }
}
