import 'package:betappadmin/constant/customdialog.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PendingUsers extends StatefulWidget {
  final List<Map<String, String>> pendingUsers;
  PendingUsers({required this.pendingUsers, Key? key});

  @override
  State<PendingUsers> createState() => _PendingUsersState();
}

class _PendingUsersState extends State<PendingUsers> {
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: themecolor,
          title: Text(
            'Pending Users',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Kanit', fontSize: 20),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: themecolor, // Change global cursor color here
            selectionHandleColor: themecolor, // Change handle color here
          ),
        ),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: StreamBuilder(
              stream: firebaseFirestore
                  .collection("users")
                  .where("userStatus", isEqualTo: "pending")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // Get the list of documents and sort it by 'time' in descending order
                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                  docs.sort((a, b) {
                    Timestamp timeA = a.get("time");
                    Timestamp timeB = b.get("time");
                    DateTime dateTimeA = timeA.toDate();
                    DateTime dateTimeB = timeB.toDate();
                    return dateTimeB.compareTo(dateTimeA);
                  });

                  return docs.isEmpty
                      ? Center(child: Text("No Pending User"))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: appSize.height * 0.85,
                              child: ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  var ds = docs[index];
                                  Map<String, dynamic>? data =
                                      ds.data() as Map<String, dynamic>?;

                                  String bproName = (data != null &&
                                          data.containsKey("UserName"))
                                      ? data["UserName"]
                                      : "";
                                  var email = (data != null &&
                                          data.containsKey("Email"))
                                      ? data["Email"]
                                      : "";
                                  var userAmount = (data != null &&
                                          data.containsKey("balance"))
                                      ? data["balance"]
                                      : "";
                                  var status = (data != null &&
                                          data.containsKey("userStatus"))
                                      ? data["userStatus"]
                                      : "";
                                  var userThrough = ds.get("boolPhone");
                                  var time = ds.get("time").toDate();
                                  String formattedTime =
                                      DateFormat('hh:mm a').format(time);
                                  var id = ds.id;

                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: status == "pending"
                                            ? () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      UserDetailDialog(
                                                          id: ds.id),
                                                );
                                              }
                                            : () {
                                                Customdialog().showInSnackBar(
                                                    "User Already Active",
                                                    context);
                                              },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 26, 153, 30),
                                              width: 2,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  bproName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kanit',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  email,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kanit',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                leading: Icon(Icons.person),
                                                trailing: GestureDetector(
                                                    onTap: () async {
                                                      await firebaseFirestore
                                                          .collection("users")
                                                          .doc(id)
                                                          .update({
                                                        "userStatus": "onHold"
                                                      }).then((value) => {
                                                                Navigator.pop(
                                                                    context),
                                                              });
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  Text(
                                                    status.toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Kanit',
                                                      color:
                                                          (status == 'pending')
                                                              ? Colors.red
                                                              : themecolor,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    formattedTime,
                                                    style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                } else if (snapshot.hasError) {
                  return Center(child: Icon(Icons.error_outline));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }
}

class UserDetailDialog extends StatefulWidget {
  String id;
  UserDetailDialog({super.key, required this.id});

  @override
  State<UserDetailDialog> createState() => _UserDetailDialogState();
}

class _UserDetailDialogState extends State<UserDetailDialog> {
  TextEditingController userName = TextEditingController();
  TextEditingController passCon = TextEditingController();

  String? status;
  Map<String, dynamic>? user;
  @override
  void initState() {
    firebaseFirestore.collection("users").doc(widget.id).get().then((value) {
      status = value.get("userStatus");
      userName = value.get("UserName");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 45,
                            child: Text(
                              'BetPro Account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                              height: 45,
                              child: TextField(
                                controller: userName,
                                style: TextStyle(fontFamily: 'Kanit'),
                                decoration: InputDecoration(
                                  labelText: 'BetPro Username',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontFamily: 'Kanit'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              )),
                          SizedBox(height: 10),
                          Container(
                              child: TextField(
                            controller: passCon,
                            style: TextStyle(fontFamily: 'Kanit'),
                            decoration: InputDecoration(
                              labelText: 'BetPro Password',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Kanit',
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: themecolor, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          )),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              await firebaseFirestore
                                  .collection("users")
                                  .doc(widget.id)
                                  .update({
                                "userStatus": "active",
                                "betProname": userName.text.trim(),
                                "betPropassword": passCon.text.trim()
                              });

                              Navigator.pop(context);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: themecolor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Active",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              Positioned(
                top: -15,
                right: -15,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
