import 'dart:io';

import 'package:betappadmin/utills/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPaymentScreen extends StatefulWidget {
  NewPaymentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NewPaymentScreen> createState() => _NewPaymentScreenState();
}

class _NewPaymentScreenState extends State<NewPaymentScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  String? selectedMethod;

  File? imageUrl;
  String? imageLink;

  final ImagePicker _picker = ImagePicker();
  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
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
          "Add Payment Method",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
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
                  controller: numController,
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
                SizedBox(height: appSize.height * 0.02),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Payment Method',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: selectedMethod,
                  items: ['JazzCash', 'EasyPaisa', 'Bank']
                      .map((method) => DropdownMenuItem<String>(
                            value: method,
                            child: Text(method),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value;
                    });
                  },
                ),
                SizedBox(height: appSize.height * 0.06),
                InkWell(
                  onTap: () async {
                    await firebaseFirestore.collection("paymentMethod").add({
                      "accountHolderName": nameController.text,
                      "accountHolderNumber": numController.text,
                      "name": selectedMethod,
                      "status": "pending"
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
      ),
    );
  }
}
