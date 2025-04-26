// import 'package:betappadmin/View/Transfers/completed_transfers.dart';
// import 'package:flutter/material.dart';
//
// class PendingTransactionRequests extends StatefulWidget {
//   const PendingTransactionRequests({super.key});
//
//   @override
//   State<PendingTransactionRequests> createState() =>
//       _PendingTransactionRequestsState();
// }
//
// class _PendingTransactionRequestsState
//     extends State<PendingTransactionRequests> {
//   final List<Map<String, String>> pendingBetProAccount = [
//     {
//       'name': 'Jane Smith',
//       'type': 'Withdraw',
//       'amount': '200',
//       'date': '2024-06-02',
//       'approved': 'Pending'
//     },
//     {
//       'name': 'Bob Brown',
//       'type': 'Withdraw',
//       'amount': '150',
//       'date': '2024-06-04',
//       'approved': 'Pending'
//     },
//     {
//       'name': 'Diana Evans',
//       'type': 'Withdraw',
//       'amount': '100',
//       'date': '2024-06-06',
//       'approved': 'Pending'
//     },
//     {
//       'name': 'Frank Green',
//       'type': 'Withdraw',
//       'amount': '300',
//       'date': '2024-06-08',
//       'approved': 'Pending'
//     },
//     {
//       'name': 'Hank Irwin',
//       'type': 'Withdraw',
//       'amount': '350',
//       'date': '2024-06-10',
//       'approved': 'Pending'
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           backgroundColor: themecolor,
//           title: const Text('Pending Transfers',
//               style: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
//           bottom: TabBar(
//             labelColor: Colors.white,
//             indicatorColor: Colors.white,
//             labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
//             tabs: [
//               Tab(
//                 text: 'BETPRO ACCOUNT',
//               ),
//               Tab(text: 'WALLET (${pendingBetProAccount.length})'),
//             ],
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.done_all_rounded,
//                 color: Colors.white,
//                 size: 30,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const CompletedTransfers(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: TabBarView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: ListView.builder(
//                 itemCount: pendingBetProAccount.length,
//                 itemBuilder: (context, index) {
//                   final transaction = pendingBetProAccount[index];
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => Dialog(
//                               insetPadding: EdgeInsets.all(20),
//                               child: Container(
//                                 padding: EdgeInsets.all(20),
//                                 child: Stack(
//                                   children: [
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             'Transfer Details',
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'Kanit'
//                                             ),
//                                           ),
//                                           Column(
//                                             children: [
//                                               Container(
//                                                 width: double.infinity,
//                                                 child: Text(
//                                                   'User Details',
//                                                   style: const TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: 'Kanit'
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.all(10),
//                                                 width: double.infinity,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                       Text('Full Name',
//                                                           style: TextStyle(
//                                                               fontFamily:
//                                                                   'Kanit',
//                                                           fontSize: 15
//                                                           )),
//                                                       Text(
//                                                         transaction['name']!,
//                                                         style: TextStyle(
//                                                             fontFamily: 'Kanit',
//                                                         fontSize: 15
//                                                         ),
//                                                       ),
//                                                     ]),
//                                                     SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('WhatsApp Number',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             '03123456789',
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                     SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('Wallet Balance',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             transaction['amount']!,
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 20,
//                                           ),
//                                           Column(
//                                             children: [
//                                               Container(
//                                                 width: double.infinity,
//                                                 child: Text(
//                                                   'BetPro Account',
//                                                   style: const TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight: FontWeight.bold,
//                                                       fontFamily: 'Kanit'),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 width: double.infinity,
//                                                 padding: EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('Username',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             transaction['name']!,
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                     SizedBox(height: 10,),
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('Balance',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             transaction['amount']!,
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     showDialog(
//                                                         context: context,
//                                                         builder: (context) =>
//                                                             AlertDialog(
//                                                               title: Text(
//                                                                 'Confirm Transfer',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                         'Kanit'),
//                                                               ),
//                                                               content: Text(
//                                                                 'Are you sure to transfer ${transaction['amount']} to BetPro Account?',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                         'Kanit',
//                                                                 fontSize: 15
//                                                                 ),
//                                                               ),
//                                                               actions: [
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'No',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                               'Kanit',
//                                                                       fontSize: 15,
//                                                                       color: Colors.black),
//                                                                     )),
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'Yes',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                               'Kanit',
//                                                                       fontSize: 15,
//                                                                       color: Colors.black
//                                                                       ),
//                                                                     )),
//                                                               ],
//                                                             ));
//                                                   },
//                                                   child: Container(
//                                                       height: 50,
//                                                       decoration: BoxDecoration(
//                                                         color: themecolor,
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 10),
//                                                       ),
//                                                       child: Center(
//                                                         child: Text(
//                                                           'Accept',
//                                                           style: TextStyle(
//                                                               color: Colors.white,
//                                                               fontFamily:
//                                                                   'Kanit'),
//                                                         ),
//                                                       )),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     showDialog(
//                                                         context: context,
//                                                         builder: (context) =>
//                                                             AlertDialog(
//                                                               title: Text(
//                                                                 'Reject Transfer',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                         'Kanit'),
//                                                               ),
//                                                               content: Text(
//                                                                 'Are you sure to reject the transfer',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                         'Kanit',
//                                                                 fontSize: 15
//                                                                 ),
//                                                               ),
//                                                               actions: [
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'No',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                               'Kanit',
//                                                                       fontSize: 15,
//                                                                       color: Colors.black
//                                                                       ),
//                                                                     )),
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'Yes',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                               'Kanit',
//                                                                       fontSize: 15,
//                                                                       color: Colors.black
//                                                                       ),
//                                                                     )),
//                                                               ],
//                                                             ));
//                                                   },
//                                                   child: Container(
//                                                       decoration: BoxDecoration(
//                                                         color: Colors.red,
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 10),
//                                                       ),
//                                                       height: 50,
//                                                       child: Center(
//                                                         child: Text(
//                                                           'Reject',
//                                                           style: TextStyle(
//                                                               color: Colors.white,
//                                                               fontFamily:
//                                                                   'Kanit',
//                                                           ),
//                                                         ),
//                                                       )),
//                                                 ),
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Positioned(
//                                         top: -5,
//                                         right: -5,
//                                         child: IconButton(
//                                           icon: Icon(Icons.close),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                                 color: const Color.fromARGB(255, 26, 153, 30),
//                                 width: 2),
//                           ),
//                           child: Column(
//                             children: [
//                               ListTile(
//                                 title: const Text(
//                                   'Transfer to Betpro Account',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'Kanit',
//                                       fontSize: 15),
//                                 ),
//                                 subtitle: Text(
//                                   'To BetPro Account\nusername: ${transaction['name']!}',
//                                   style: TextStyle(fontFamily: 'Kanit'),
//                                 ),
//                                 leading: const Icon(Icons.download),
//                                 trailing: Text(
//                                   'Rs: ${transaction['amount']}',
//                                   style: const TextStyle(
//                                       fontSize: 15, fontFamily: 'Kanit'),
//                                 ),
//                               ),
//                               Divider(),
//                               Row(
//                                 children: [
//                                   const SizedBox(width: 10),
//                                   Text('${transaction['approved']!}',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontFamily: 'Kanit',
//                                           color: (transaction['approved'] ==
//                                                   'Pending')
//                                               ? Colors.red
//                                               : themecolor)),
//                                   const Spacer(),
//                                   Text(
//                                     transaction['date']!,
//                                     style: TextStyle(fontFamily: 'Kanit'),
//                                   ),
//                                   const SizedBox(width: 10),
//                                 ],
//                               ),
//                               SizedBox(height: 5)
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10)
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: ListView.builder(
//                 itemCount: pendingBetProAccount.length,
//                 itemBuilder: (context, index) {
//                   final transaction = pendingBetProAccount[index];
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => Dialog(
//                               insetPadding: EdgeInsets.all(20),
//                               child: Container(
//                                 padding: EdgeInsets.all(20),
//                                 child: Stack(
//                                   children: [
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             'Transfer Details',
//                                             style: TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: 'Kanit'
//                                             ),
//                                           ),
//                                           Column(
//                                             children: [
//                                               Container(
//                                                 width: double.infinity,
//                                                 child: Text(
//                                                   'User Details',
//                                                   style: const TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight: FontWeight.bold,
//                                                       fontFamily: 'Kanit'
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.all(10),
//                                                 width: double.infinity,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1,
//                                                   ),
//                                                   borderRadius:
//                                                   BorderRadius.circular(10),
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('Full Name',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             transaction['name']!,
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                     SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('WhatsApp Number',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             '03123456789',
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                     SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('Wallet Balance',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             transaction['amount']!,
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 20,
//                                           ),
//                                           Column(
//                                             children: [
//                                               Container(
//                                                 width: double.infinity,
//                                                 child: Text(
//                                                   'BetPro Account',
//                                                   style: const TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight: FontWeight.bold,
//                                                       fontFamily: 'Kanit'),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 width: double.infinity,
//                                                 padding: EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1,
//                                                   ),
//                                                   borderRadius:
//                                                   BorderRadius.circular(10),
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('Username',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             transaction['name']!,
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                     SizedBox(height: 10,),
//                                                     Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text('Balance',
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                   'Kanit',
//                                                                   fontSize: 15
//                                                               )),
//                                                           Text(
//                                                             transaction['amount']!,
//                                                             style: TextStyle(
//                                                                 fontFamily: 'Kanit',
//                                                                 fontSize: 15
//                                                             ),
//                                                           ),
//                                                         ]),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     showDialog(
//                                                         context: context,
//                                                         builder: (context) =>
//                                                             AlertDialog(
//                                                               title: Text(
//                                                                 'Confirm Transfer',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                     'Kanit'),
//                                                               ),
//                                                               content: Text(
//                                                                 'Are you sure to transfer ${transaction['amount']} to BetPro Account?',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                     'Kanit',
//                                                                     fontSize: 15
//                                                                 ),
//                                                               ),
//                                                               actions: [
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'No',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                           'Kanit',
//                                                                           fontSize: 15,
//                                                                           color: Colors.black),
//                                                                     )),
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'Yes',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                           'Kanit',
//                                                                           fontSize: 15,
//                                                                           color: Colors.black
//                                                                       ),
//                                                                     )),
//                                                               ],
//                                                             ));
//                                                   },
//                                                   child: Container(
//                                                       height: 50,
//                                                       decoration: BoxDecoration(
//                                                         color: themecolor,
//                                                         borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                       ),
//                                                       child: Center(
//                                                         child: Text(
//                                                           'Accept',
//                                                           style: TextStyle(
//                                                               color: Colors.white,
//                                                               fontFamily:
//                                                               'Kanit'),
//                                                         ),
//                                                       )),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     showDialog(
//                                                         context: context,
//                                                         builder: (context) =>
//                                                             AlertDialog(
//                                                               title: Text(
//                                                                 'Reject Transfer',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                     'Kanit'),
//                                                               ),
//                                                               content: Text(
//                                                                 'Are you sure to reject the transfer',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                     'Kanit',
//                                                                     fontSize: 15
//                                                                 ),
//                                                               ),
//                                                               actions: [
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'No',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                           'Kanit',
//                                                                           fontSize: 15,
//                                                                           color: Colors.black
//                                                                       ),
//                                                                     )),
//                                                                 TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Text(
//                                                                       'Yes',
//                                                                       style: TextStyle(
//                                                                           fontFamily:
//                                                                           'Kanit',
//                                                                           fontSize: 15,
//                                                                           color: Colors.black
//                                                                       ),
//                                                                     )),
//                                                               ],
//                                                             ));
//                                                   },
//                                                   child: Container(
//                                                       decoration: BoxDecoration(
//                                                         color: Colors.red,
//                                                         borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                       ),
//                                                       height: 50,
//                                                       child: Center(
//                                                         child: Text(
//                                                           'Reject',
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontFamily:
//                                                             'Kanit',
//                                                           ),
//                                                         ),
//                                                       )),
//                                                 ),
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Positioned(
//                                         top: -5,
//                                         right: -5,
//                                         child: IconButton(
//                                           icon: Icon(Icons.close),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                                 color: const Color.fromARGB(255, 26, 153, 30),
//                                 width: 2),
//                           ),
//                           child: Column(
//                             children: [
//                               ListTile(
//                                 title: const Text(
//                                   'Transfer to Wallet',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Kanit'),
//                                 ),
//                                 subtitle: Text(
//                                   'From BetPro Account\nusername: ${transaction['name']!}',
//                                   style: TextStyle(fontFamily: 'Kanit'),
//                                 ),
//                                 leading: const Icon(Icons.download),
//                                 trailing: Text(
//                                   'Rs: ${transaction['amount']}',
//                                   style: const TextStyle(
//                                       fontSize: 15, fontFamily: 'Kanit'),
//                                 ),
//                               ),
//                               Divider(),
//                               Row(
//                                 children: [
//                                   const SizedBox(width: 10),
//                                   Text('${transaction['approved']!}',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontFamily: 'Kanit',
//                                           color: (transaction['approved'] ==
//                                                   'Pending')
//                                               ? Colors.red
//                                               : themecolor)),
//                                   const Spacer(),
//                                   Text(
//                                     transaction['date']!,
//                                     style: TextStyle(fontFamily: 'Kanit'),
//                                   ),
//                                   const SizedBox(width: 10),
//                                 ],
//                               ),
//                               SizedBox(height: 5)
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10)
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:betappadmin/View/Webview/webview.dart';
import 'package:betappadmin/constant/customdialog.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:betappadmin/View/Transfers/completed_transfers.dart';
import 'package:betappadmin/utills/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int selectedIndex = 0;

  void _selectOption(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Transfers',
          style: TextStyle(color: Colors.white, fontFamily: 'Kanit'),

          ),
          actions: [
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
                    builder: (context) => const CompletedTransfersScreen(),
                  ),
                );
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _selectOption(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? Colors.green : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        'To Wallet',
                        style: TextStyle(
                          color: selectedIndex == 0 ? Colors.white : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectOption(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedIndex == 1 ? Colors.green : Colors.grey[200],
                                              borderRadius: BorderRadius.circular(10)

                      ),
                      child: Text(
                        'To Account',
                        style: TextStyle(
                          color: selectedIndex == 1 ? Colors.white : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: const [
                     ToWallet(),
                     ToAccount(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToWallet extends StatefulWidget {
  const ToWallet({super.key});

  @override
  State<ToWallet> createState() => _ToWalletState();
}

class _ToWalletState extends State<ToWallet> {
 var wallet;

  String? userId;
  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;
    return    StreamBuilder(
        stream: firebaseFirestore
            .collection("transfer").where("bankType",isEqualTo: "my BPro Account").where("status",isEqualTo: "pending").snapshots(),
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


                        var userAmount=ds.get("amount");
                        var id=ds.get("senderId");
                        return  Column(
                          children: [
                            StreamBuilder(
                                stream: firebaseFirestore
                                    .collection("users")
                                    .doc(id)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    var ds = snapshot.data!;
                                    wallet=ds.get("balance").toString();
                                    userId=ds.id;
                                    print("wallet is $wallet");

                                    return SizedBox();
                                  } else if (snapshot.hasError) {
                                    return Center(child: const Icon(Icons.error_outline));
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                }),
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
                                                  Text(
                                                    "To:        ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                  SizedBox(width: 15,),
                                                  Text(
                                                    "Wallet",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                ],
                                              ),
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
                                      Divider(),
                                      Padding(
                                        padding:  EdgeInsets.all(8.0),
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
                                      ds.get("status")=="pending"?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap:() async{
                                              double enteredAmount = double.parse(userAmount);
                                              double walletAmount = double.parse(wallet);
                                              var newAmount=walletAmount+enteredAmount;
                                              await firebaseFirestore.collection("transfer").doc(ds.id).update({
                                                "status":"approved",

                                              });
    await firebaseFirestore
        .collection("users")
        .doc(id)
        .update({
    "balance": newAmount.toString(),});
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 150,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,borderRadius: BorderRadius.circular(7)
                                              ),
                                              child: Text("Accept",style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap:() async{
                                              await firebaseFirestore.collection("transfer").doc(ds.id).update({
                                                "status":"rejected",

                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 150,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,borderRadius: BorderRadius.circular(7)
                                              ),
                                              child: Text("Reject",style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ):SizedBox(),
                                      SizedBox(height: 10,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
        });
  }
}

class ToAccount extends StatefulWidget {
  const ToAccount({super.key});

  @override
  State<ToAccount> createState() => _ToAccountState();
}

class _ToAccountState extends State<ToAccount> {
  var userId;
  var wallet;
  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;
    return StreamBuilder(
        stream: firebaseFirestore
            .collection("transfer").where("bankType",isEqualTo: "this wallet").where("status",isEqualTo: "pending").snapshots(),
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
                        var userAmount=ds.get("amount");
                        var id=ds.get("senderId");
                        return  Column(
                          children: [
                            StreamBuilder(
                                stream: firebaseFirestore
                                    .collection("users")
                                    .doc(id)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    var ds = snapshot.data!;
                                   wallet=ds.get("balance").toString();
                                    userId=ds.id;
                                    print("wallet is $wallet");
                                    return SizedBox();
                                  } else if (snapshot.hasError) {
                                    return Center(child: const Icon(Icons.error_outline));
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                }),
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
Align(
  alignment: Alignment.topRight,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  StoreWebView(url: "", done: true),
          ),
        );
                        },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text("Verify",style: TextStyle(
          color: Colors.white
        ),),
      ),
    ),
  ),
),
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
                                                  Text(
                                                    "To:        ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                  SizedBox(width: 15,),
                                                  Text(
                                                    "B Pro Acoount",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Kanit'),
                                                  ),
                                                ],
                                              ),
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
                                       Divider(),
                                      Padding(
                                        padding:  EdgeInsets.all(8.0),
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
                                      ds.get("status")=="pending"?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap:() async{
                                              await firebaseFirestore.collection("transfer").doc(ds.id).update({
                                                "status":"approved",

                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 150,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.green,borderRadius: BorderRadius.circular(7)
                                              ),
                                              child: Text("Accept",style: TextStyle(
                                                color: Colors.white
                                              ),),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap:() async{
                                              double enteredAmount = double.parse(userAmount);
                                              double walletAmount = double.parse(wallet);
                                              var newAmount=walletAmount+enteredAmount;
                                              await firebaseFirestore.collection("transfer").doc(ds.id).update({
                                                "status":"rejected",

                                              });
    await firebaseFirestore
        .collection("users")
        .doc(id)
        .update({
      "balance": newAmount.toString(),
    } );
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 150,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.red,borderRadius: BorderRadius.circular(7)
                                              ),
                                              child: Text("Reject",style: TextStyle(
                                                color: Colors.white
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ):SizedBox(),
                                      SizedBox(height: 10,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
        });
  }
}


