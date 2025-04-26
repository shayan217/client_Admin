import 'package:betappadmin/constant/customdialog.dart';
import 'package:betappadmin/constant/imageCustomWidget.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompletedTransfersScreen extends StatefulWidget {
  const CompletedTransfersScreen({super.key});

  @override
  State<CompletedTransfersScreen> createState() => _CompletedTransfersScreenState();
}

class _CompletedTransfersScreenState extends State<CompletedTransfersScreen> {

  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;

    return DefaultTabController(
      length: 6, // This should match the number of tabs
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: themecolor,
          title: const Text('Transfers',
              style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit'),
            isScrollable: true,
            tabs: [


              Tab(
                text: 'ACCEPTED To Wallet',
              ),
              Tab(
                text: 'ACCEPTED To BPro',
              ),

              Tab(
                text: 'REJECTED To Wallet',
              ),
              Tab(
                text: 'REJECTED To BPro',
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: [
        StreamBuilder(
        stream: firebaseFirestore
            .collection("transfer").where("status",isEqualTo: "approved").where("bankType",isEqualTo: "my BPro Account").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasData) {
              var data= snapshot.data!;
              return
                snapshot.data?.size == 0
                    ? Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Center(child: Text("No History")),
                ):

                Column(
                  children: [
                    Container(
                      height:appSize.height*0.77,

                      child: ListView.builder(

                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<DocumentSnapshot> docs = snapshot.data!.docs;

                          // Sort the documents based on the 'time' field
                          docs.sort((a, b) {
                            // Get the 'time' field as a Timestamp
                            Timestamp timeA = a.get("time");
                            Timestamp timeB = b.get("time");

                            // Convert Timestamp to DateTime
                            DateTime dateTimeA = timeA.toDate();
                            DateTime dateTimeB = timeB.toDate();

                            // Sort in descending order (latest time first)
                            return dateTimeB.compareTo(dateTimeA);
                          });

                          var ds = docs[index];
                          var time = ds.get("time").toDate();
                          String formattedTime = DateFormat('hh:mm a').format(time);
                          var status=ds.get("status");
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: themecolor),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                    child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5,),

                                          Container(
                                            child: ListTile(
                                              title:  Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "From:",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Text(
                                                        "${ds.get("bankType").toString().capitalize}",
                                                        style: TextStyle(
                                                            color: themecolor,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                              subtitle: Column(
                                                children: [

                                                  Row(
                                                    children: [
                                                      Container(


                                                        child: Text(
                                                          "UserName:  ${ds.get("accountName").toString().capitalize}", // Dummy value
                                                          style: TextStyle(fontFamily: 'Kanit'),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.copy),
                                                        onPressed: () {
                                                          Clipboard.setData(ClipboardData(text:ds.get("accountName")));
                                                          Customdialog().showInSnackBar("UserName Copied", context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Password:  ${ds.get("accountPassword").toString().capitalize}", // Dummy value
                                                          style: TextStyle(fontFamily: 'Kanit'),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.copy),
                                                        onPressed: () {
                                                          Clipboard.setData(ClipboardData(text:ds.get("accountPassword")));
                                                          Customdialog().showInSnackBar("Account Password Copied to Clipboard", context);

                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      "${ds.get("email").toString()}", // Dummy value
                                                      style: TextStyle(fontFamily: 'Kanit'),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              trailing: Text(
                                                "${ds.get("amount").toString()} Rs", // Dummy value
                                                style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${ds.get("status").toString().capitalize}", // Dummy value
                                                  style: TextStyle(

                                                      color:ds.get("status")=="approved"? Colors.green:Colors.red, fontFamily: 'Kanit'),
                                                ),
                                                Text(
                                                  "$formattedTime / ${ds.get("date")}", // Dummy value
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),



                  ],
                );
            }
            else if (snapshot.hasError) {
              return Center(child: const Icon(Icons.error_outline));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        StreamBuilder(
        stream: firebaseFirestore
            .collection("transfer").where("status",isEqualTo: "approved").where("bankType",isEqualTo: "this wallet").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasData) {
              var data= snapshot.data!;
              return
                snapshot.data?.size == 0
                    ? Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Center(child: Text("No History")),
                ):

                Column(
                  children: [
                    Container(
                      height:appSize.height*0.77,

                      child: ListView.builder(

                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<DocumentSnapshot> docs = snapshot.data!.docs;

                          // Sort the documents based on the 'time' field
                          docs.sort((a, b) {
                            // Get the 'time' field as a Timestamp
                            Timestamp timeA = a.get("time");
                            Timestamp timeB = b.get("time");

                            // Convert Timestamp to DateTime
                            DateTime dateTimeA = timeA.toDate();
                            DateTime dateTimeB = timeB.toDate();

                            // Sort in descending order (latest time first)
                            return dateTimeB.compareTo(dateTimeA);
                          });

                          var ds = docs[index];
                          var time = ds.get("time").toDate();
                          String formattedTime = DateFormat('hh:mm a').format(time);
                          var status=ds.get("status");
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: themecolor),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                    child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5,),

                                          Container(
                                            child: ListTile(
                                              title:  Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "From:",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Text(
                                                        "${ds.get("bankType").toString().capitalize}",
                                                        style: TextStyle(
                                                            color: themecolor,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                              subtitle: Column(
                                                children: [

                                                  Row(
                                                    children: [
                                                      Container(


                                                        child: Text(
                                                          "UserName:  ${ds.get("accountName").toString().capitalize}", // Dummy value
                                                          style: TextStyle(fontFamily: 'Kanit'),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.copy),
                                                        onPressed: () {
                                                          Clipboard.setData(ClipboardData(text:ds.get("accountName")));
                                                          Customdialog().showInSnackBar("UserName Copied", context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Password:  ${ds.get("accountPassword").toString().capitalize}", // Dummy value
                                                          style: TextStyle(fontFamily: 'Kanit'),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.copy),
                                                        onPressed: () {
                                                          Clipboard.setData(ClipboardData(text:ds.get("accountPassword")));
                                                          Customdialog().showInSnackBar("Account Password Copied to Clipboard", context);

                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      "${ds.get("email").toString()}", // Dummy value
                                                      style: TextStyle(fontFamily: 'Kanit'),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              trailing: Text(
                                                "${ds.get("amount").toString()} Rs", // Dummy value
                                                style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${ds.get("status").toString().capitalize}", // Dummy value
                                                  style: TextStyle(

                                                      color:ds.get("status")=="approved"? Colors.green:Colors.red, fontFamily: 'Kanit'),
                                                ),
                                                Text(
                                                  "$formattedTime / ${ds.get("date")}", // Dummy value
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),



                  ],
                );
            }
            else if (snapshot.hasError) {
              return Center(child: const Icon(Icons.error_outline));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),

        StreamBuilder(
        stream: firebaseFirestore
            .collection("transfer").where("status",isEqualTo: "rejected").where("bankType",isEqualTo: "my BPro Account").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasData) {
              var data= snapshot.data!;
              return
                snapshot.data?.size == 0
                    ? Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Center(child: Text("No History")),
                ):

                Column(
                  children: [
                    Container(
                      height:appSize.height*0.77,

                      child: ListView.builder(

                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<DocumentSnapshot> docs = snapshot.data!.docs;

                          // Sort the documents based on the 'time' field
                          docs.sort((a, b) {
                            // Get the 'time' field as a Timestamp
                            Timestamp timeA = a.get("time");
                            Timestamp timeB = b.get("time");

                            // Convert Timestamp to DateTime
                            DateTime dateTimeA = timeA.toDate();
                            DateTime dateTimeB = timeB.toDate();

                            // Sort in descending order (latest time first)
                            return dateTimeB.compareTo(dateTimeA);
                          });

                          var ds = docs[index];
                          var time = ds.get("time").toDate();
                          String formattedTime = DateFormat('hh:mm a').format(time);
                          var status=ds.get("status");
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: themecolor),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                    child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5,),

                                          Container(
                                            child: ListTile(
                                              title:  Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "From:",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Text(
                                                        "${ds.get("bankType").toString().capitalize}",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                              subtitle: Column(
                                                children: [

                                                  Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      "UserName:  ${ds.get("accountName").toString().capitalize}", // Dummy value
                                                      style: TextStyle(fontFamily: 'Kanit'),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      "Password:  ${ds.get("accountPassword").toString().capitalize}", // Dummy value
                                                      style: TextStyle(fontFamily: 'Kanit'),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      "${ds.get("email").toString()}", // Dummy value
                                                      style: TextStyle(fontFamily: 'Kanit'),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              trailing: Text(
                                                "${ds.get("amount").toString()} Rs", // Dummy value
                                                style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${ds.get("status").toString().capitalize}", // Dummy value
                                                  style: TextStyle(

                                                      color:ds.get("status")=="approved"? Colors.green:Colors.red, fontFamily: 'Kanit'),
                                                ),
                                                Text(
                                                  "$formattedTime / ${ds.get("date")}", // Dummy value
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),



                  ],
                );
            }
            else if (snapshot.hasError) {
              return Center(child: const Icon(Icons.error_outline));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        StreamBuilder(
        stream: firebaseFirestore
            .collection("transfer").where("status",isEqualTo: "rejected").where("bankType",isEqualTo: "this wallet").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasData) {
              var data= snapshot.data!;
              return
                snapshot.data?.size == 0
                    ? Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Center(child: Text("No History")),
                ):

                Column(
                  children: [
                    Container(
                      height:appSize.height*0.77,

                      child: ListView.builder(

                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<DocumentSnapshot> docs = snapshot.data!.docs;

                          // Sort the documents based on the 'time' field
                          docs.sort((a, b) {
                            // Get the 'time' field as a Timestamp
                            Timestamp timeA = a.get("time");
                            Timestamp timeB = b.get("time");

                            // Convert Timestamp to DateTime
                            DateTime dateTimeA = timeA.toDate();
                            DateTime dateTimeB = timeB.toDate();

                            // Sort in descending order (latest time first)
                            return dateTimeB.compareTo(dateTimeA);
                          });

                          var ds = docs[index];
                          var time = ds.get("time").toDate();
                          String formattedTime = DateFormat('hh:mm a').format(time);
                          var status=ds.get("status");
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                    child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5,),

                                          Container(
                                            child: ListTile(
                                              title:  Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "From:",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Text(
                                                        "${ds.get("bankType").toString().capitalize}",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Kanit'),
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                              subtitle: Column(
                                                children: [

                                                  Row(
                                                    children: [
                                                      Container(


                                                        child: Text(
                                                          "UserName:  ${ds.get("accountName").toString().capitalize}", // Dummy value
                                                          style: TextStyle(fontFamily: 'Kanit'),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.copy),
                                                        onPressed: () {
                                                          Clipboard.setData(ClipboardData(text:ds.get("accountName")));
                                                          Customdialog().showInSnackBar("UserName Copied", context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Password:  ${ds.get("accountPassword").toString().capitalize}", // Dummy value
                                                          style: TextStyle(fontFamily: 'Kanit'),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.copy),
                                                        onPressed: () {
                                                          Clipboard.setData(ClipboardData(text:ds.get("accountPassword")));
                                                          Customdialog().showInSnackBar("Account Password Copied to Clipboard", context);

                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      "${ds.get("email").toString()}", // Dummy value
                                                      style: TextStyle(fontFamily: 'Kanit'),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              trailing: Text(
                                                "${ds.get("amount").toString()} Rs", // Dummy value
                                                style: const TextStyle(fontSize: 15, fontFamily: 'Kanit'),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${ds.get("status").toString().capitalize}", // Dummy value
                                                  style: TextStyle(

                                                      color:ds.get("status")=="approved"? Colors.green:Colors.red, fontFamily: 'Kanit'),
                                                ),
                                                Text(
                                                  "$formattedTime / ${ds.get("date")}", // Dummy value
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),



                  ],
                );
            }
            else if (snapshot.hasError) {
              return Center(child: const Icon(Icons.error_outline));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),


          ],
        ),
      ),
    );
  }
}
