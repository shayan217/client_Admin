import 'dart:ffi';

import 'package:betappadmin/View/Transactions/pending.dart';
import 'package:betappadmin/View/Webview/webview.dart';
import 'package:betappadmin/View/addWhattsappNumber.dart';
import 'package:betappadmin/View/paymentScreen.dart';
import 'package:betappadmin/View/pending_users.dart';
import 'package:betappadmin/View/total_users.dart';
import 'package:betappadmin/View/updatePaymentMethod.dart';
import 'package:betappadmin/View/view_history.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  bool isSwitchedAcc1 = false;
  bool isSwitchedAcc2 = false;
  TextEditingController aboutController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController processTimeController = TextEditingController();

  String about =
      'Ab \'betprocash.com\' se aap apk download ker sakte hain or apne doston k sath share ker sakte hain.';
  String supportDetail = 'Contact Support 24/7  03103208154';
  String processTime = '30 Minutes';

  List<File> images = [];

  File? _image;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  final List<Map<String, String>> pendingUserss = [
    {
      'name': 'John Doe',
      'amount': '500',
      'number': '03123456789',
      'date': '2024-06-01',
      'status': 'BetPro Activated'
    },
    {
      'name': 'Alice Johnson',
      'amount': '300',
      'number': '03123456789',
      'date': '2024-06-03',
      'status': 'BetPro Activated'
    },
    {
      'name': 'Charlie Davis',
      'amount': '400',
      'number': '03123456789',
      'date': '2024-06-05',
      'status': 'BetPro Activated'
    },
    {
      'name': 'Eve Foster',
      'amount': '250',
      'number': '03123456789',
      'date': '2024-06-07',
      'status': 'BetPro Inactive'
    },
    {
      'name': 'Grace Hall',
      'amount': '450',
      'number': '03123456789',
      'date': '2024-06-09',
      'status': 'BetPro Inactive'
    },
  ];

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: themecolor, // Change global cursor color here
            selectionHandleColor: themecolor, // Change handle color here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: appSize.width * 0.45,
                      margin: const EdgeInsets.only(top: 10),
                      height: appSize.height * 0.1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PendingTransactions()));
                        },
                        child: Card(
                          color: themecolor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Transactions',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              StreamBuilder(
                                  stream: firebaseFirestore
                                      .collection("paymentRecord")
                                      .where("status", isEqualTo: "pending")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data!.docs.length == 0
                                          ? Center(
                                              child: Text(
                                              "0",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                          : Text(
                                              "${snapshot.data!.docs.length}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Icon(Icons.error_outline));
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: appSize.width * 0.45,
                      margin: const EdgeInsets.only(top: 10),
                      height: appSize.height * 0.1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TotalUsers()));
                        },
                        child: Card(
                          color: themecolor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Users',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              StreamBuilder(
                                  stream: firebaseFirestore
                                      .collection("users")
                                      .where("userStatus", isEqualTo: "active")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data!.docs.length == 0
                                          ? Center(
                                              child: Text(
                                              "0",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                          : Text(
                                              "${snapshot.data!.docs.length}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Icon(Icons.error_outline));
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: appSize.width * 0.45,
                      margin: const EdgeInsets.only(top: 10),
                      height: appSize.height * 0.1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PendingUsers(
                                        pendingUsers: pendingUserss,
                                      )));
                        },
                        child: Card(
                          color: themecolor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Pending Users',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              StreamBuilder(
                                  stream: firebaseFirestore
                                      .collection("users")
                                      .where("userStatus", isEqualTo: "pending")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data!.docs.length == 0
                                          ? Center(
                                              child: Text(
                                              "0",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                          : Text(
                                              "${snapshot.data!.docs.length}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Icon(Icons.error_outline));
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewHistory()));
                      },
                      child: Container(
                        width: appSize.width * 0.45,
                        margin: const EdgeInsets.only(top: 10),
                        height: appSize.height * 0.1,
                        child: Card(
                          color: themecolor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    StreamBuilder(
                        stream:
                            firebaseFirestore.collection("users").snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.docs.length == 0
                                ? Center(child: Text("0"))
                                : Text(
                                    "${snapshot.data!.docs.length}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  );
                          } else if (snapshot.hasError) {
                            return Center(child: Icon(Icons.error_outline));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: appSize.width * 0.46,
                      child: StreamBuilder(
                          stream: firebaseFirestore
                              .collection("socialInfo")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              var ds = snapshot.data?.docs.last;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoreWebView(
                                                url: ds?.get("webviewUrl"),
                                                done: true,
                                              )));
                                },
                                child: Container(
                                  width: appSize.width * 0.45,
                                  height: 80,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StoreWebView(
                                                    url: ds?.get("webviewUrl"),
                                                    done: true,
                                                  )));
                                    },
                                    child: Card(
                                      color: themecolor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Web',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Icon(Icons.error_outline));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                    Container(
                      width: appSize.width * 0.46,
                      child: StreamBuilder(
                          stream: firebaseFirestore
                              .collection("socialInfo")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              var ds = snapshot.data?.docs.last;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SocialLinkScreen(
                                                // id: "VQ493umX1yXdWvk07n5T",
                                                id: "VDghuf3zrrcCfRGBYbEa",
                                                link: ds?.get("whatsAppNumber"),
                                                webview: ds?.get("webviewUrl"),
                                                shareText: ds?.get("shareText"),
                                                annoucement:
                                                    ds?.get("annoucement"),
                                                withdrawTime:
                                                    ds?.get("withdrawTime"),
                                                depositTime:
                                                    ds?.get("depositTime"),
                                                appLink: ds?.get("appLink"),
                                              )));
                                },
                                child: Container(
                                  width: appSize.width * 0.45,
                                  height: 80,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SocialLinkScreen(
                                                    // id: "VQ493umX1yXdWvk07n5T",
                                                    id: "VDghuf3zrrcCfRGBYbEa",
                                                    link: ds
                                                        ?.get("whatsAppNumber"),
                                                    webview:
                                                        ds?.get("webviewUrl"),
                                                    shareText:
                                                        ds?.get("shareText"),
                                                    annoucement:
                                                        ds?.get("annoucement"),
                                                    withdrawTime:
                                                        ds?.get("withdrawTime"),
                                                    depositTime:
                                                        ds?.get("depositTime"),
                                                    appLink: ds?.get("appLink"),
                                                  )));
                                    },
                                    child: Card(
                                      color: themecolor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Social Link',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Icon(Icons.error_outline));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewPaymentScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: themecolor, width: 2),
                    ),
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 50, right: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black.withOpacity(0.2), width: 2),
                        ),
                        child: Center(
                          child: Text(
                            'Add payment method',
                            style: TextStyle(
                                color: themecolor,
                                fontSize: 20,
                                fontFamily: 'Kanit'),
                          ),
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                StreamBuilder(
                  stream:
                      firebaseFirestore.collection("paymentMethod").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.docs;

                      return snapshot.data?.size == 0
                          ? Center(child: Text("No Payment Method "))
                          : Column(
                              children: [
                                Container(
                                  height: appSize.height * 0.425,
                                  width: appSize.width,
                                  child: ListView.builder(
                                      itemCount: data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var ds = snapshot.data?.docs[index];
                                        var name = ds?.get("name");
                                        var numbr =
                                            ds?.get("accountHolderNumber");
                                        var title =
                                            ds?.get("accountHolderName");
                                        var status = ds?.get("status");
                                        var id = ds?.id;

                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: appSize.height * 0.04,
                                            ),
                                            CustomTile(
                                                index,
                                                name.toString().toLowerCase() ==
                                                        "jazzcash"
                                                    ? 'assets/images/jazzcash.jpg'
                                                    : name
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "easypaisa"
                                                        ? 'assets/images/easypaisa.png'
                                                        : 'assets/images/bank.png',
                                                ds?.get("accountHolderName"),
                                                ds?.get("accountHolderNumber"),
                                                name.toString().toUpperCase(),
                                                status,
                                                id.toString()),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            );
                    } else if (snapshot.hasError) {
                      return Center(child: const Icon(Icons.error_outline));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomTile(int value, String url, String title, String subtitle,
      String bankName, String status, String docId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentUpdateScreen(
              number: subtitle,
              name: title,
              id: docId,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: themecolor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                bankName,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                    fontFamily: 'Kanit'),
              ),
              CircleAvatar(
                backgroundImage: AssetImage(url),
                radius: 20,
              ),
            ],
          ),
          title: Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit')),
          subtitle: Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                  fontFamily: 'Kanit')),
          trailing: Switch(
            value: status.toLowerCase() == 'active',
            onChanged: (bool newValue) {
              // Update the status in the database
              FirebaseFirestore.instance
                  .collection('paymentMethod')
                  .doc(docId)
                  .update({
                'status': newValue ? 'active' : 'pending',
              }).then((_) {
                print('Status updated successfully');
              }).catchError((error) {
                print('Failed to update status: $error');
              });

              setState(() {
                status = newValue ? 'active' : 'pending';
              });
            },
            activeColor: themecolor,
          ),
        ),
      ),
    );
  }
}
