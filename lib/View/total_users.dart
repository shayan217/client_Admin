import 'package:betappadmin/constant/accessToken.dart';
import 'package:betappadmin/constant/customdialog.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class TotalUsers extends StatefulWidget {
  TotalUsers({
    super.key,
  });

  @override
  State<TotalUsers> createState() => _TotalUsersState();
}

class _TotalUsersState extends State<TotalUsers> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              "Total Users  ",
              style: TextStyle(color: Colors.white),
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
                        ? Center(child: Text("0"))
                        : Text(
                            "(${snapshot.data!.docs.length})",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
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
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: themecolor, // Change global cursor color here
            selectionHandleColor: themecolor, // Change handle color here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Enter Name, Email, WA# or Email",
                    labelStyle:
                        TextStyle(color: Colors.black, fontFamily: 'Kanit'),
                    hintStyle: TextStyle(fontFamily: 'Kanit'),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themecolor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
                const SizedBox(height: 10),
                StreamBuilder(
                  stream: firebaseFirestore.collection("users").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var filteredDocs = snapshot.data!.docs.where((doc) {
                        var userName =
                            doc.get("UserName").toString().toLowerCase();
                        var phoneNumber =
                            doc.get("phoneNumber").toString().toLowerCase();
                        var email = doc.get("Email").toString().toLowerCase();
                        return userName.contains(searchQuery) ||
                            phoneNumber.contains(searchQuery) ||
                            email.contains(searchQuery);
                      }).toList();

                      return filteredDocs.isEmpty
                          ? Center(child: Text("No Data"))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: appSize.height * 0.77,
                                  child: ListView.builder(
                                    itemCount: filteredDocs.length,
                                    itemBuilder: (context, index) {
                                      var ds = filteredDocs[index];
                                      var status = ds.get("userStatus");
                                      var boolUser = ds.get("boolPhone");

                                      return status == "onHold"
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        UserDetailDialog(
                                                      id: ds.id,
                                                      status: status,
                                                      Email: ds.get("Email"),
                                                      betProname:
                                                          ds.get("betProname"),
                                                      betProPassword: ds.get(
                                                          "betPropassword"),
                                                      userName:
                                                          ds.get("UserName"),
                                                      phoneNo:
                                                          ds.get("phoneNumber"),
                                                      password: ds
                                                          .get("userPassword"),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 26, 153, 30),
                                                          width: 2),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            ds.get("UserName"),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Kanit',
                                                                fontSize: 13),
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
                                                                'WA: ${ds.get("phoneNumber")}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              Text(
                                                                boolUser ==
                                                                        false
                                                                    ? ds.get(
                                                                        "Email")
                                                                    : ds.get(
                                                                        "phoneNumber"),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                            ],
                                                          ),
                                                          leading: CircleAvatar(
                                                            radius: 23,
                                                            backgroundColor:
                                                                Colors.black,
                                                            child: Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          trailing: Text(
                                                            'Current Balance \n Rs: ${ds.get("balance")}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Kanit'),
                                                          ),
                                                        ),
                                                        const Divider(),
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                                ds.get("userStatus") ==
                                                                        "active"
                                                                    ? "BetPro Active"
                                                                    : 'BetPro Inactive',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    color: ds.get("userStatus") ==
                                                                            "active"
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red)),
                                                            const Spacer(),
                                                            Text(
                                                              ds.get(
                                                                  "userStatus"),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Kanit'),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10)
                                                ],
                                              ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserDetailDialog extends StatefulWidget {
  String id;
  String status;
  String betProname;
  String betProPassword;
  String Email;
  String phoneNo;
  String userName;
  String password;
  UserDetailDialog(
      {super.key,
      required this.id,
      required this.phoneNo,
      required this.Email,
      required this.betProPassword,
      required this.betProname,
      required this.status,
      required this.userName,
      required this.password});

  @override
  State<UserDetailDialog> createState() => _UserDetailDialogState();
}

class _UserDetailDialogState extends State<UserDetailDialog> {
  TextEditingController userName = TextEditingController();
  TextEditingController bProName = TextEditingController(text: "");
  TextEditingController bProPassword = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    userName = widget.userName != null && widget.userName.isNotEmpty
        ? TextEditingController(text: widget.userName)
        : TextEditingController();
    bProName = widget.betProname != null && widget.betProname.isNotEmpty
        ? TextEditingController(text: widget.betProname)
        : TextEditingController();
    bProPassword =
        widget.betProPassword != null && widget.betProPassword.isNotEmpty
            ? TextEditingController(text: widget.betProPassword)
            : TextEditingController();
    password = widget.password != null && widget.password.isNotEmpty
        ? TextEditingController(text: widget.password)
        : TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 45,
                        child: Text(
                          'User Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                              fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                                fontSize: 15),
                          ),
                          Text(
                            widget.Email,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Kanit',
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone No.',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                                fontSize: 15),
                          ),
                          Text(
                            widget.phoneNo,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Kanit',
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: userName,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter UserName Number',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: themecolor.withOpacity(0.8), width: 1.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: themecolor.withOpacity(0.8),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(15.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: themecolor.withOpacity(0.8),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'BetProName',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: appSize.width * 0.6,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              controller: bProName,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter BPro Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themecolor.withOpacity(0.8),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor.withOpacity(0.8),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor.withOpacity(0.8),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: widget.betProname));
                                Customdialog().showInSnackBar(
                                    "BPRo Name Copied", context);
                              },
                              child: Icon(
                                Icons.copy,
                                color: Colors.grey,
                                size: 25,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'BetPro Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: appSize.width * 0.6,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              controller: bProPassword,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter BPro Password',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themecolor.withOpacity(0.8),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor.withOpacity(0.8),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor.withOpacity(0.8),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: widget.betProPassword));
                                Customdialog().showInSnackBar(
                                    "BPRo Password Copied", context);
                              },
                              child: Icon(
                                Icons.copy,
                                color: Colors.grey,
                                size: 25,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: appSize.width * 0.6,
                            child: TextFormField(
                              enabled: false,
                              style: TextStyle(color: Colors.black),
                              controller: password,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: ' Password',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themecolor.withOpacity(0.8),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor.withOpacity(0.8),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themecolor.withOpacity(0.8),
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: widget.password));
                                Customdialog()
                                    .showInSnackBar("Password Copied", context);
                              },
                              child: Icon(
                                Icons.copy,
                                color: Colors.grey,
                                size: 25,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BitPro Status',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                                fontSize: 15),
                          ),
                          Switch(
                            value: widget.status.toLowerCase() == 'active',
                            onChanged: (bool newValue) {
                              // Update the status in the database
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.id)
                                  .update({
                                'userStatus': newValue ? 'active' : 'pending',
                              }).then((_) {
                                print('Status updated successfully');
                              }).catchError((error) {
                                print('Failed to update status: $error');
                              });

                              setState(() {
                                widget.status = newValue ? 'active' : 'pending';
                              });
                            },
                            activeColor: themecolor,
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            await firebaseFirestore
                                .collection("users")
                                .doc(widget.id)
                                .update({
                              "UserName": userName.text.trim(),
                              "betPropassword": bProPassword.text.trim(),
                              "betProname": bProName.text.trim()
                            });
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: 'User updated successfully',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: themecolor,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: themecolor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      )
                    ],
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
