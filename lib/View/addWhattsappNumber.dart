import 'dart:io';
import 'package:betappadmin/utills/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SocialLinkScreen extends StatefulWidget {
  String link;
String annoucement;
  String id;
  String appLink;
  String withdrawTime;
  String depositTime;
  String shareText;
  String webview;


  SocialLinkScreen({Key? key,required this.id,required this.link,required this.annoucement,
  required this.appLink,required this.depositTime,required this.shareText,required this.webview,required this.withdrawTime

  }) : super(key: key);

  @override
  State<SocialLinkScreen> createState() => _SocialLinkScreenState();
}

class _SocialLinkScreenState extends State<SocialLinkScreen> {
  final GlobalKey<FormState>key=GlobalKey<FormState>();
  TextEditingController whatsAppController=TextEditingController();
  TextEditingController announcCon=TextEditingController();
  TextEditingController appLinkCon=TextEditingController();
  TextEditingController webviewCon=TextEditingController();
  TextEditingController shareCon=TextEditingController();
  TextEditingController depositCon=TextEditingController();
  TextEditingController withdrawlCon=TextEditingController();





  void initState() {
    // TODO: implement initState
    super.initState();
    whatsAppController = widget.link != null && widget.link.isNotEmpty
        ? TextEditingController(text: widget.link)
        : TextEditingController();

    announcCon = widget.annoucement != null && widget.annoucement.isNotEmpty
        ? TextEditingController(text: widget.annoucement)
        : TextEditingController();

    appLinkCon = widget.appLink != null && widget.appLink.isNotEmpty
        ? TextEditingController(text: widget.appLink)
        : TextEditingController();

    shareCon = widget.shareText != null && widget.shareText.isNotEmpty
        ? TextEditingController(text: widget.shareText)
        : TextEditingController();

    webviewCon = widget.webview != null && widget.webview.isNotEmpty
        ? TextEditingController(text: widget.webview)
        : TextEditingController();


    depositCon = widget.depositTime != null && widget.depositTime.isNotEmpty
        ? TextEditingController(text: widget.depositTime)
        : TextEditingController();

    withdrawlCon = widget.withdrawTime != null && widget.withdrawTime.isNotEmpty
        ? TextEditingController(text: widget.withdrawTime)
        : TextEditingController();

  }


  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:themecolor,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);

            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white)),
        title: Text("Social Update",style: TextStyle(
          color: Colors.white,



        ),),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left: appSize.width*0.05,right: appSize.width*0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: appSize.height * 0.02),
                Text("WhatsApp Number",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
            
            
            
                ),),
                SizedBox(height: appSize.height * 0.01),
                TextFormField(
            
                  style: TextStyle(color: Colors.black),
                  controller: whatsAppController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter Whattsapp Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
            
            
                SizedBox(height: appSize.height * 0.015),
                Text("App Link",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
            
            
            
                ),),
                SizedBox(height: appSize.height * 0.01),
                TextFormField(
            
                  style: TextStyle(color: Colors.black),
                  controller: appLinkCon,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter App Link',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
            
                SizedBox(height: appSize.height * 0.015),
                Text("Deposit Time",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
            
            
            
                ),),
                SizedBox(height: appSize.height * 0.01),
                TextFormField(
            
                  style: TextStyle(color: Colors.black),
                  controller: depositCon,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Deposit Time',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
            
            
                SizedBox(height: appSize.height * 0.015),
                Text("Withdraw Time",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
            
            
            
                ),),
                SizedBox(height: appSize.height * 0.01),
                TextFormField(
            
                  style: TextStyle(color: Colors.black),
                  controller: withdrawlCon,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Withdraw Time',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
            
                SizedBox(height: appSize.height * 0.015),
                Text("Webview Url",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
            
            
            
                ),),
                SizedBox(height: appSize.height * 0.01),
                TextFormField(
            
                  style: TextStyle(color: Colors.black),
                  controller: webviewCon,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Webview Url',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
            
                SizedBox(height: appSize.height * 0.015),
                Text("Share Text",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
            
            
            
                ),),
                SizedBox(height: appSize.height * 0.01),
                TextFormField(

                  style: TextStyle(color: Colors.black),
                  controller: shareCon,
                  keyboardType: TextInputType.name,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Text To Share',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
                SizedBox(height: appSize.height * 0.015),
                Text("Annoucements",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold



                ),),
                SizedBox(height: appSize.height * 0.01),

                TextFormField(

                  style: TextStyle(color: Colors.black),
                  controller: announcCon,
                  keyboardType: TextInputType.name,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Enter Annoucement Text',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themecolor.withOpacity(0.8), width: 1.5), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
                SizedBox(height: appSize.height * 0.06),
            
                InkWell(
                  onTap: () async {
            
                    await firebaseFirestore.collection("socialInfo").doc(widget.id).update({
                      "whatsAppNumber":whatsAppController.text,
                      "annoucement":announcCon.text,
                      "appLink":appLinkCon.text,
                      "depositTime":depositCon.text,
                      "withdrawTime":withdrawlCon.text,
                      "webviewUrl":webviewCon.text,
                      "shareText":shareCon.text
            
            
            
                    }).then((value) => {
                      Navigator.pop(context),
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: appSize.height * 0.04),
                    height: appSize.height * 0.07,
                    width: appSize.width * 0.92,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: themecolor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: appSize.width * 0.045),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
