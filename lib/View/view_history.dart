import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewHistory extends StatefulWidget {
  const ViewHistory({super.key});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');

  // Function to calculate days ago
  String calculateDaysAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return '$difference days ago';
    }
  }

  var data;
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: themecolor,
        title: Text(
          'Transactions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("paymentRecord")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var docs = snapshot.data!.docs;

                // Initialize overall totals
                int overallTotalDeposit = 0;
                int overallTotalWithdraw = 0;

                // Group transactions by date
                var groupedDocs = <DateTime, List<QueryDocumentSnapshot>>{};

                for (var doc in docs) {
                  // Convert Firestore timestamp to DateTime
                  var timestamp = doc.get("currentDate");
                  DateTime date;
                  if (timestamp is Timestamp) {
                    date = timestamp.toDate();
                  } else if (timestamp is String) {
                    date = DateTime.parse(timestamp);
                  } else {
                    continue;
                  }

                  // Use only the date portion (no time) for grouping
                  var dateKey = DateTime(date.year, date.month, date.day);
                  if (!groupedDocs.containsKey(dateKey)) {
                    groupedDocs[dateKey] = [];
                  }
                  groupedDocs[dateKey]!.add(doc);

                  // Check if the transaction is approved
                  var status = doc.get("status") ?? "";
                  if (status.toLowerCase() != "approved") {
                    continue; // Skip unapproved transactions
                  }

                  // Calculate overall totals
                  var paymentType = doc.get("paymentType");
                  int amount;
                  try {
                    amount = (doc.get("amount") as num).toInt();
                  } catch (e) {
                    amount = int.tryParse(doc.get("amount").toString()) ?? 0;
                  }

                  if (paymentType == "deposit") {
                    overallTotalDeposit += amount;
                  } else if (paymentType == "withdraw") {
                    overallTotalWithdraw += amount;
                  }
                }

                // Sort dates in descending order (most recent first)
                var sortedDates = groupedDocs.keys.toList()
                  ..sort((a, b) => b.compareTo(a));

                // Calculate remaining balance (approved deposits - approved withdrawals)
                var total = overallTotalDeposit - overallTotalWithdraw;
                return Column(
                  children: [
                    SizedBox(height: 15),
                    Card(
                      elevation: 4,
                      color: themecolor,
                      child: Container(
                        width: appSize.width * 0.94,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Account Remaining Balance:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Rs. $total',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Total Overall Deposit:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Rs. $overallTotalDeposit',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Overall Withdraw:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Rs. $overallTotalWithdraw',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
          Container(
            height: appSize.height * 0.69,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("paymentRecord")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var docs = snapshot.data!.docs;

                  // Initialize overall totals
                  int overallTotalDeposit = 0;
                  int overallTotalWithdraw = 0;

                  // Group transactions by date
                  var groupedDocs = <DateTime, List<QueryDocumentSnapshot>>{};
                  data = groupedDocs;

                  for (var doc in docs) {
                    // Convert Firestore timestamp to DateTime
                    var timestamp = doc.get("currentDate");
                    DateTime date;
                    if (timestamp is Timestamp) {
                      date = timestamp.toDate();
                    } else if (timestamp is String) {
                      date = DateTime.parse(timestamp);
                    } else {
                      continue;
                    }

                    // Use only the date portion (no time) for grouping
                    var dateKey = DateTime(date.year, date.month, date.day);
                    if (!groupedDocs.containsKey(dateKey)) {
                      groupedDocs[dateKey] = [];
                    }
                    groupedDocs[dateKey]!.add(doc);

                    // Calculate overall totals
                    var paymentType = doc.get("paymentType");
                    int amount;
                    try {
                      amount = (doc.get("amount") as num).toInt();
                    } catch (e) {
                      amount = int.tryParse(doc.get("amount")) ?? 0;
                    }

                    if (paymentType == "deposit") {
                      overallTotalDeposit += amount;
                    } else if (paymentType == "withdraw") {
                      overallTotalWithdraw += amount;
                    }
                  }

                  // Sort dates in descending order (most recent first)
                  var sortedDates = groupedDocs.keys.toList()
                    ..sort((a, b) => b.compareTo(a));
                  var total = overallTotalDeposit - overallTotalWithdraw;
                  return Column(
                    children: [
                      // Transactions List
                      Expanded(
                        child: groupedDocs.isEmpty
                            ? Center(child: Text("No Transactions"))
                            : ListView(
                                padding: EdgeInsets.all(8),
                                children: [
                                  // Example balance
                                  buildSummaryCard(
                                      "Today's Summary",
                                      sortedDates
                                          .where((date) => isToday(date))
                                          .toList()),
                                  buildSummaryCard(
                                      "Yesterday's Summary",
                                      sortedDates
                                          .where((date) => isYesterday(date))
                                          .toList()),
                                  buildSummaryCard(
                                      "This Month's Summary",
                                      sortedDates
                                          .where((date) => isThisMonth(date))
                                          .toList()),
                                ],
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
          ),
        ],
      ),
    );
  }

  Widget buildAccountBalanceCard(int balance) {
    return Card(
      color: themecolor,
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Account Remaining Balance",
                style: TextStyle(fontSize: 16, color: Colors.white)),
            SizedBox(height: 5),
            Text("Rs: $balance",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

// Function to build Summary Card
  Widget buildSummaryCard(String title, List<DateTime> dates) {
    if (dates.isEmpty) return SizedBox.shrink();

    int totalDepositAccepted = 0, totalDepositRejected = 0;
    int totalWithdrawAccepted = 0, totalWithdrawRejected = 0;

    for (var dateKey in dates) {
      List<QueryDocumentSnapshot> transactions = data[dateKey]!;
      transactions.forEach((doc) {
        var status = doc.get("status");
        var paymentType = doc.get("paymentType");

        int amount;
        try {
          amount = (doc.get("amount") as num).toInt();
        } catch (e) {
          amount = int.tryParse(doc.get("amount").toString()) ?? 0;
        }

        if (status == "approved") {
          if (paymentType == "deposit") {
            totalDepositAccepted += amount;
          } else if (paymentType == "withdraw") {
            totalWithdrawAccepted += amount;
          }
        } else if (status == "rejected") {
          if (paymentType == "deposit") {
            totalDepositRejected += amount;
          } else if (paymentType == "withdraw") {
            totalWithdrawRejected += amount;
          }
        }
      });
    }

    return Card(
      color: themecolor,
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            buildTransactionText(
                'Approved Deposits', totalDepositAccepted, Colors.white),
            buildTransactionText(
                'Rejected Deposits', totalDepositRejected, Colors.red),
            buildTransactionText(
                'Approved Withdrawals', totalWithdrawAccepted, Colors.white),
            buildTransactionText(
                'Rejected Withdrawals', totalWithdrawRejected, Colors.red),
          ],
        ),
      ),
    );
  }

// Function to build transaction summary text
  Widget buildTransactionText(String label, int amount, Color color) {
    return Text(
      '$label: $amount',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
    );
  }

// Date Filters
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(now);
  }

  bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(yesterday);
  }

  bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }
}
