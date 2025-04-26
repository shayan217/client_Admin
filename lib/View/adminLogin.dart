import 'package:betappadmin/View/admin_panel.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:betappadmin/utills/localdatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.only(
                left: appSize.width * 0.05,
                right: appSize.width * 0.05,
                top: appSize.height * 0.27),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Admin Login',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: themecolor),
                ),
                SizedBox(height: appSize.height * 0.06),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("adminLogin")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var docs = snapshot.data!.docs; // List of documents

                      // Assuming you want to get the first document
                      if (docs.isNotEmpty) {
                        var email = docs.first.get("email").toString();
                        var password = docs.first.get("password").toString();

                        return Column(
                          children: [
                            TextFormField(
                              validator:
                                  RequiredValidator(errorText: "Required"),
                              style: TextStyle(color: Colors.black),
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: themecolor, width: 1.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor, width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor, width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator:
                                  RequiredValidator(errorText: "Required"),
                              style: TextStyle(color: Colors.black),
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: themecolor, width: 1.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor, width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor, width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  if (emailController.text == email &&
                                      passwordController.text == password) {
                                    await LocalDatabase()
                                        .setData(key: "login", value: true);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminPanel()),
                                        (route) => false);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Wrong email password")));
                                  }
                                }
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: appSize.height * 0.07),
                                height: appSize.height * 0.07,
                                width: appSize.width * 0.88,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: themecolor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: appSize.width * 0.045),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text("No admin found");
                      }
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
