import 'package:betappadmin/utills/constants.dart';
import 'package:betappadmin/View/Transactions/specificUserHistory.dart';
import 'package:betappadmin/View/Transactions/transactions.dart';
import 'package:betappadmin/constant/customdialog.dart';
import 'package:betappadmin/constant/imageCustomWidget.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class PendingTransactions extends StatefulWidget {
  const PendingTransactions({super.key});

  @override
  State<PendingTransactions> createState() => _PendingTransactionsState();
}

class _PendingTransactionsState extends State<PendingTransactions> {
  var wallet;

  String? userId;
  String? withdrawUser;

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2, // This should match the number of tabs
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: themecolor,
          title: const Text('Pending Transactions',
              style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
          bottom: const TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit'),
            tabs: [
              Tab(
                text: 'DEPOSIT',
              ),
              Tab(text: 'WITHDRAW'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.done_all_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Transactions(),
                  ),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
                stream: firebaseFirestore
                    .collection("paymentRecord")
                    .where("paymentType", isEqualTo: "deposit")
                    .where("status", isEqualTo: "pending")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length == 0
                        ? Center(child: Text("No Transactions"))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: appSize.height * 0.7,
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    List<DocumentSnapshot> docs =
                                        snapshot.data!.docs;

                                    // Sort the documents based on the 'time' field
                                    docs.sort((a, b) {
                                      Timestamp timeA = a.get("time");
                                      Timestamp timeB = b.get("time");
                                      DateTime dateTimeA = timeA.toDate();
                                      DateTime dateTimeB = timeB.toDate();
                                      return dateTimeB.compareTo(dateTimeA);
                                    });

                                    var ds = docs[index];
                                    // var bproName=ds.get("bproName");

                                    var timestamp = ds.get("time") as Timestamp;
                                    DateTime dateTime = timestamp.toDate();

                                    // Format time as "hh:mm a"
                                    String formattedTime =
                                        DateFormat('hh:mm a').format(dateTime);

                                    // Use timeago to show relative time like "2 hours ago"
                                    String relativeTime =
                                        timeago.format(dateTime);
                                    var status = ds.get("status");
                                    var id = ds.get("senderId");

                                    var userAmount = ds.get("amount");
                                    DateTime now = DateTime.now();
                                    bool isRecent =
                                        now.difference(dateTime).inSeconds < 15;

                                    Map<String, dynamic>? data =
                                        ds.data() as Map<String, dynamic>?;

                                    String imageUrl = (data != null &&
                                            data.containsKey("imageLink"))
                                        ? data["imageLink"]
                                        : "";
                                    print("aaaaaaaaaaaaaaaaa${ds.id}");
                                    return StreamBuilder<DocumentSnapshot>(
                                      stream: firebaseFirestore
                                          .collection("users")
                                          .doc(id)
                                          .snapshots(),
                                      builder: (context, userSnapshot) {
                                        if (userSnapshot.hasData) {
                                          var userData = userSnapshot.data!;
                                          var userName =
                                              userData.get("UserName");
                                          var userNumer =
                                              userData.get("phoneNumber");
                                          var userBpro =
                                              userData.get("betProname");
                                          var userPassword =
                                              userData.get("betPropassword");

                                          double userAmountDouble =
                                              double.parse(
                                                  userAmount.toString());
                                          // double userBalanceDouble = double.parse(userBalance.toString());

                                          // Calculate the new amount
                                          // double newAmount = userAmountDouble + userBalanceDouble;
                                          // print(newAmount);

                                          return Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            backgroundColor:
                                                                Colors.white,
                                                            title: Text(
                                                                'User Info',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey)),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "UserName",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userName.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "WhatsApp No.",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userNumer.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "BPro Name",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userBpro.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "BPro Password",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userPassword.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => SpecificUserHistory(userId: ds.get("senderId")),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              Text(
                                                                            "View History",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 12,
                                                                              decoration: TextDecoration.underline,
                                                                              decorationColor: Colors.blue,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                      'Transfer Account',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "BPro",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              themecolor,
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            'Ac Title:  ${userBpro.toString()}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.black,
                                                                              fontFamily: 'Kanit',
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                Clipboard.setData(ClipboardData(text: userBpro.toString()));
                                                                                Customdialog().showInSnackBar("Account Name Copied", context);
                                                                              },
                                                                              child: Icon(
                                                                                Icons.copy,
                                                                                color: Colors.grey,
                                                                                size: 22,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Password  : ${userPassword.toString()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                Clipboard.setData(ClipboardData(text: userPassword.toString()));
                                                                                Customdialog().showInSnackBar("Account Password Copied", context);
                                                                              },
                                                                              child: Icon(
                                                                                Icons.copy,
                                                                                color: Colors.grey,
                                                                                size: 22,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await firebaseFirestore
                                                                            .collection("paymentRecord")
                                                                            .doc(ds.id)
                                                                            .update({
                                                                          "status":
                                                                              "rejected",
                                                                          "currentDate":
                                                                              DateTime.now(),
                                                                        });

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        height: appSize.height *
                                                                            0.055,
                                                                        width: appSize.width *
                                                                            0.25,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            border: Border.all(color: themecolor, width: 1.5)),
                                                                        child:
                                                                            Text(
                                                                          'Reject',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Kanit',
                                                                              fontSize: 15,
                                                                              color: themecolor),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await firebaseFirestore
                                                                            .collection("paymentRecord")
                                                                            .doc(ds.id)
                                                                            .update({
                                                                          "status":
                                                                              "approved",
                                                                          "currentDate":
                                                                              DateTime.now(),
                                                                        });

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        height: appSize.height *
                                                                            0.055,
                                                                        width: appSize.width *
                                                                            0.25,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            border: Border.all(color: themecolor, width: 1.5),
                                                                            color: themecolor),
                                                                        child:
                                                                            const Text(
                                                                          'Accept',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Kanit',
                                                                              fontSize: 15,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ));
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 26, 153, 30),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            ds
                                                                .get(
                                                                    "paymentType")
                                                                .toString()
                                                                .toUpperCase(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Kanit',
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'To: ${ds.get("accountTitle").toString().capitalizeFirst}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    ds
                                                                        .get(
                                                                            "bankType")
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          themecolor,
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    ds
                                                                        .get(
                                                                            "accountNo")
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "From",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              themecolor,
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        userName
                                                                            .toString()
                                                                            .toUpperCase(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await firebaseFirestore
                                                                          .collection(
                                                                              "paymentRecord")
                                                                          .doc(ds
                                                                              .id)
                                                                          .delete();
                                                                    },
                                                                    child: Container(
                                                                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                                                                        padding: EdgeInsets.all(4),
                                                                        child: Text(
                                                                          " Delete ",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          leading:
                                                              GestureDetector(
                                                            onTap: () {
                                                              if (imageUrl
                                                                  .isNotEmpty) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        FullScreenImagePage(
                                                                            imageUrl),
                                                                  ),
                                                                );
                                                              } else {
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg:
                                                                      'User has not uploaded image yet',
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      themecolor,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0,
                                                                );
                                                              }
                                                            },
                                                            child: Image.asset(
                                                                "assets/images/Image.png",
                                                                scale: 2.3),
                                                          ),
                                                          trailing: Text(
                                                            'Rs: ${ds.get("amount")}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Kanit'),
                                                          ),
                                                        ),
                                                        const Divider(),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                ds
                                                                    .get(
                                                                        "status")
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color: ds.get(
                                                                              "status") ==
                                                                          "approved"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${relativeTime}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              Text(
                                                                "$formattedTime / ${ds.get("date")}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          );
                                        } else if (userSnapshot.hasError) {
                                          return Center(
                                              child: const Icon(
                                                  Icons.error_outline));
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                  } else if (snapshot.hasError) {
                    return Center(child: Icon(Icons.error_outline));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            StreamBuilder(
                stream: firebaseFirestore
                    .collection("paymentRecord")
                    .where("paymentType", isEqualTo: "withdraw")
                    .where("status", isEqualTo: "pending")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length == 0
                        ? Center(child: Text("No Transactions"))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: appSize.height * 0.7,
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    List<DocumentSnapshot> docs =
                                        snapshot.data!.docs;

                                    // Sort the documents based on the 'time' field
                                    docs.sort((a, b) {
                                      Timestamp timeA = a.get("time");
                                      Timestamp timeB = b.get("time");
                                      DateTime dateTimeA = timeA.toDate();
                                      DateTime dateTimeB = timeB.toDate();
                                      return dateTimeB.compareTo(dateTimeA);
                                    });

                                    var ds = docs[index];
                                    // var bproName=ds.get("bproName");

                                    var timestamp = ds.get("time") as Timestamp;
                                    DateTime dateTime = timestamp.toDate();

                                    // Format time as "hh:mm a"
                                    String formattedTime =
                                        DateFormat('hh:mm a').format(dateTime);

                                    // Use timeago to show relative time like "2 hours ago"
                                    String relativeTime =
                                        timeago.format(dateTime);
                                    var status = ds.get("status");
                                    var id = ds.get("senderId");
                                    var image = ds.get("imageLink");
                                    var userAmount = ds.get("amount");

                                    return StreamBuilder<DocumentSnapshot>(
                                      stream: firebaseFirestore
                                          .collection("users")
                                          .doc(id)
                                          .snapshots(),
                                      builder: (context, userSnapshot) {
                                        if (userSnapshot.hasData) {
                                          var userData = userSnapshot.data!;
                                          var userName =
                                              userData.get("UserName");
                                          var userNumer =
                                              userData.get("phoneNumber");
                                          var userBpro =
                                              userData.get("betProname");
                                          var userPassword =
                                              userData.get("betPropassword");

                                          double userAmountDouble =
                                              double.parse(
                                                  userAmount.toString());
                                          // double userBalanceDouble = double.parse(userBalance.toString());

                                          // Calculate the new amount
                                          // double newAmount = userAmountDouble + userBalanceDouble;
                                          // print(newAmount);

                                          return Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            backgroundColor:
                                                                Colors.white,
                                                            title: Text(
                                                                'User Info',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey)),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "UserName",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userName.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "WhatsApp No",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userNumer.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "BPro Name",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userBpro.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "BPro Password",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${userPassword.toString().toUpperCase()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => SpecificUserHistory(userId: ds.get("senderId")),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              Text(
                                                                            "View History",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 12,
                                                                              decoration: TextDecoration.underline,
                                                                              decorationColor: Colors.blue,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                      'Withdraw Account',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "BPro",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              themecolor,
                                                                          fontFamily:
                                                                              'Kanit',
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            'Ac Title:  ${userBpro.toString()}',
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.black,
                                                                              fontFamily: 'Kanit',
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                Clipboard.setData(ClipboardData(text: userBpro.toString()));
                                                                                Customdialog().showInSnackBar("Account Name Copied", context);
                                                                              },
                                                                              child: Icon(
                                                                                Icons.copy,
                                                                                color: Colors.grey,
                                                                                size: 22,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Password  : ${userPassword.toString()}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'Kanit',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                Clipboard.setData(ClipboardData(text: userPassword.toString()));
                                                                                Customdialog().showInSnackBar("Account Password Copied", context);
                                                                              },
                                                                              child: Icon(
                                                                                Icons.copy,
                                                                                color: Colors.grey,
                                                                                size: 22,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await firebaseFirestore
                                                                            .collection("paymentRecord")
                                                                            .doc(ds.id)
                                                                            .update({
                                                                          "status":
                                                                              "rejected",
                                                                          "currentDate":
                                                                              DateTime.now(),
                                                                        });

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        height: appSize.height *
                                                                            0.055,
                                                                        width: appSize.width *
                                                                            0.25,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            border: Border.all(color: themecolor, width: 1.5)),
                                                                        child:
                                                                            Text(
                                                                          'Reject',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Kanit',
                                                                              fontSize: 15,
                                                                              color: themecolor),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await firebaseFirestore
                                                                            .collection("paymentRecord")
                                                                            .doc(ds.id)
                                                                            .update({
                                                                          "status":
                                                                              "approved",
                                                                          "currentDate":
                                                                              DateTime.now(),
                                                                        });

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        height: appSize.height *
                                                                            0.055,
                                                                        width: appSize.width *
                                                                            0.25,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            border: Border.all(color: themecolor, width: 1.5),
                                                                            color: themecolor),
                                                                        child:
                                                                            const Text(
                                                                          'Accept',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Kanit',
                                                                              fontSize: 15,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ));
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 26, 153, 30),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            ds
                                                                .get(
                                                                    "paymentType")
                                                                .toString()
                                                                .toUpperCase(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Kanit',
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'To: ${ds.get("accountTitle").toString().capitalizeFirst}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    ds
                                                                        .get(
                                                                            "bankType")
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          themecolor,
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    ds
                                                                        .get(
                                                                            "accountNo")
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              // Row(
                                                              //   children: [
                                                              //     Text(
                                                              //       'BPro Name: $bproName',
                                                              //       style: const TextStyle(
                                                              //         color: Colors.black,
                                                              //         fontFamily: 'Kanit',
                                                              //         fontSize: 13,
                                                              //       ),
                                                              //     ),
                                                              //     SizedBox(width: 10,),
                                                              //     GestureDetector(
                                                              //         onTap: (){
                                                              //           Clipboard.setData(ClipboardData(text:bproName));
                                                              //           Customdialog().showInSnackBar("BPRo Name Copied", context);
                                                              //         },
                                                              //         child: Icon(Icons.copy,color: Colors.grey,size: 22,))
                                                              //   ],
                                                              // ),
                                                              // Text(
                                                              //   'Balance: $userBalance',
                                                              //   style: const TextStyle(
                                                              //     color: Colors.black,
                                                              //     fontFamily: 'Kanit',
                                                              //     fontSize: 13,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          trailing: Text(
                                                            'Rs: ${ds.get("amount")}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Kanit'),
                                                          ),
                                                        ),
                                                        const Divider(),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                ds
                                                                    .get(
                                                                        "status")
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color: ds.get(
                                                                              "status") ==
                                                                          "approved"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${relativeTime}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              Text(
                                                                "$formattedTime / ${ds.get("date")}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          );
                                        } else if (userSnapshot.hasError) {
                                          return Center(
                                              child: const Icon(
                                                  Icons.error_outline));
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
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
                }),
          ],
        ),
      ),
    );
  }
  // void showCustomDialog(BuildContext context) {
  //   var size=MediaQuery.of(context).size;
  //   showDialog(
  //     context: context,
  //
  //     builder: (context) {
  //       return Dialog(
  //         backgroundColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: Padding(
  //           padding:  EdgeInsets.all(25.0),
  //           child: SingleChildScrollView(
  //             child:,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
