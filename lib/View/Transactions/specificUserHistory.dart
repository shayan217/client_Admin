import 'package:betappadmin/constant/imageCustomWidget.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
class SpecificUserHistory extends StatefulWidget {
  var userId;
   SpecificUserHistory({super.key,required this.userId});

  @override
  State<SpecificUserHistory> createState() => _SpecificUserHistoryState();
}

class _SpecificUserHistoryState extends State<SpecificUserHistory> {
  var username;
  var email;
  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: themecolor,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text("History",style: TextStyle(
          color: Colors.white
        ),),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: firebaseFirestore.collection("paymentRecord").where("senderId",isEqualTo: widget.userId).snapshots(),
        
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {


                    double approvedDepositSum = 0.0;
                    double approvedWithdrawSum = 0.0;

                    List<DocumentSnapshot> docs = snapshot.data!.docs;

                    for (var doc in docs) {
                      if (doc.get("status") == "approved") {
                        var amount = double.parse(doc.get("amount").toString());  // Convert amount to double
                        if (doc.get("paymentType") == "deposit") {
                          approvedDepositSum += amount;
                        } else if (doc.get("paymentType") == "withdraw") {
                          approvedWithdrawSum += amount;
                        }
                      }
                    }
                    return snapshot.data!.docs.length == 0
                        ? Center(child: Text("No Transactions"))
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 15,top: 10),
                        child: Text(
                        "Approved Deposit : Rs. $approvedDepositSum",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: themecolor,
                        ),
                                            ),
                      ),
                  Padding(
                    padding:  EdgeInsets.only(left: 15,top: 2),
                    child: Text(
                    "Approved Withdraw : Rs. $approvedWithdrawSum",
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themecolor,
                    ),
                    ),
                  ),
                        Container(
                          height: appSize.height*0.87,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
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
                              var  status= ds.get("status");
                              var id=ds.get("senderId");
                              Map<String, dynamic>? data = ds.data() as Map<String, dynamic>?;

                              String imageUrl = (data != null && data.containsKey("imageLink")) ? data["imageLink"] : "";
                              var userAmount=ds.get("amount");
                              var transactionType=ds.get("paymentType");
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [

                                    GestureDetector(
                                      onTap:(){
        
                                      },
                                      child:  Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: const Color.fromARGB(255, 26, 153, 30),
                                              width: 2),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: Text(
                                                ds.get("paymentType").toString().toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Kanit',
                                                    fontSize: 13),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
        
                                                  Text(
                                                    'TID: ${ ds.id}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Kanit',
                                                        fontSize: 13),
                                                  ),
                                                  Text(
                                                    ds.get("bankType").toString().toUpperCase(),
                                                    style:  TextStyle(
                                                        color: themecolor,
                                                        fontFamily: 'Kanit',
                                                        fontSize: 13),
                                                  ),
        
                                                ],
                                              ),
                                              leading: GestureDetector(
                                                  onTap: (){
                                                    if(imageUrl.isEmpty){
                                                      Fluttertoast.showToast(
                                                        msg: 'This user have no reciept',
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: themecolor,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                    }
                                                    else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (
                                                              context) =>
                                                              FullScreenImagePage(
                                                                  imageUrl),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Image.asset("assets/images/Image.png",scale: 2.3),),
                                              trailing: Text(
                                                'Rs: ${ ds.get("amount")}',
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    fontSize: 13, fontFamily: 'Kanit'),
                                              ),
                                            ),
                                            Row(
                                              children: [
        
                                                Padding(
                                                  padding:  EdgeInsets.only(left: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text( "Account Name",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Kanit',
                                                              color:
                                                              Colors.black
                                                          )),
                                                      Text( ds.get("accountTitle").toString().toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Kanit',
                                                              color:
                                                              Colors.black
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:  EdgeInsets.only(left: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text( "Account Number",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Kanit',
                                                              color:
                                                              Colors.black
                                                          )),
                                                      Text( ds.get("accountNo").toString().toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: 'Kanit',
                                                              color:
                                                              Colors.black
                                                          )),
        

                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
        
        
                                            Divider(),
                                            StreamBuilder(
                                                stream: firebaseFirestore
                                                    .collection("users")
                                                    .doc(id)
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                  if (snapshot.hasData) {
                                                    var ds = snapshot.data!;
                                                    username=ds.get("UserName");
                                                    email=ds.get("Email");
                                                    var boolUser=ds.get("boolPhone");
                                                    return Padding(
                                                      padding:  EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text( "UserName: ${username}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily: 'Kanit',
                                                                  color:
                                                                  Colors.black
                                                              )),
                                                          Text( "${boolUser==true?"Phone Number:":"Email: "} ${boolUser==false?email:ds.get("phoneNumber")}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily: 'Kanit',
                                                                  color:
                                                                  Colors.black
                                                              )),
                                                        ],
                                                      ),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    return Center(child: const Icon(Icons.error_outline));
                                                  } else {
                                                    return Center(child: CircularProgressIndicator());
                                                  }
                                                }),

                                            Row(
                                              children: [
                                                const SizedBox(width: 10),
                                                Text( ds.get("status").toString().toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Kanit',
                                                        color:
                                                        ds.get("status")=="approved"?
                                                        themecolor:Colors.red
                                                    )),
                                                const Spacer(),
                                                Text( "$formattedTime / ${ds.get("date")}",
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit'
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                            const SizedBox(height: 5)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
        
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
                }),
          ],
        ),
      )
    );
  }
}
