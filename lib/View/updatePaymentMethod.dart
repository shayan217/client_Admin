import 'dart:io';
import 'package:betappadmin/utills/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaymentUpdateScreen extends StatefulWidget {
  String name;
  String number;
  String id;

  PaymentUpdateScreen(
      {Key? key, required this.id, required this.name, required this.number})
      : super(key: key);

  @override
  State<PaymentUpdateScreen> createState() => _PaymentUpdateScreenState();
}

class _PaymentUpdateScreenState extends State<PaymentUpdateScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = widget.name != null && widget.name.isNotEmpty
        ? TextEditingController(text: widget.name)
        : TextEditingController();
    numberController = widget.number != null && widget.number.isNotEmpty
        ? TextEditingController(text: widget.number)
        : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themecolor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text(
          "Transaction Update",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: appSize.height * 0.06),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Account Holder Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themecolor.withOpacity(0.8), width: 1.5),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              SizedBox(height: appSize.height * 0.02),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Account Holder Number',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themecolor.withOpacity(0.8), width: 1.5),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: themecolor.withOpacity(0.8), width: 1.5),
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              SizedBox(height: appSize.height * 0.06),
              InkWell(
                onTap: () async {
                  await firebaseFirestore
                      .collection("paymentMethod")
                      .doc(widget.id)
                      .update({
                    "accountHolderName": nameController.text,
                    "accountHolderNumber": numberController.text,
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
                    color: themecolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: appSize.width * 0.045),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
