// import 'dart:math';
// import 'package:betappadmin/View/adminLogin.dart';
// import 'package:betappadmin/View/splash_screen.dart';
// import 'package:betappadmin/constant/notification_services.dart';
// import 'package:betappadmin/utills/localdatabase.dart';
// import 'package:betappadmin/utills/notificationapi.dart';
// import 'package:betappadmin/utills/utilities.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //       apiKey: "AIzaSyAez5H8cOZqdfqA5giTnllbRIaI0Mf1bHw",
  //       appId: "1:1009360561313:android:97ef888d7e46afe8bd7ce0",
  //       messagingSenderId: "1009360561313",
  //       projectId: "insect-microscopy-disease-dete",
  //       storageBucket: 'insect-microscopy-disease-dete.appspot.com'),
  // );

//   _requestNotificationPermission();
//   runApp(
//     AdminPanel(),
//   );
// }

// class AdminPanel extends StatefulWidget {
//   const AdminPanel({super.key});

//   @override
//   State<AdminPanel> createState() => _AdminPanelState();
// }

// class _AdminPanelState extends State<AdminPanel> {
//   NotificationServices notificationServices = NotificationServices();
//   bool? type;
//   getData() async {
//     final a = await LocalDatabase().getData(key: "login");
//     setState(() {
//       type = a;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//     Utility.subScribeTopic("all");
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//       print("message recieved" + event.toMap().toString());
//       print(event.notification!.body);
//       print(event.notification!.body);
//       int id = Random().nextInt(1000) + 50;
//       print("id" + id.toString());
//       if (event.data != null && event.data['imageUrl'] != null) {
//         NotificationApi.showBigPictureNotificationHiddenLargeIcon(
//             event.notification!.title.toString(),
//             event.notification!.body.toString(),
//             event.data['imageUrl']);
//       } else {
//         NotificationApi.ShowNotification(
//           id: id,
//           title: event.notification!.title,
//           body: event.notification!.body,
//           payload: "",
//         );
//       }
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       print('A new onMessageOpenedApp event was published!');
//       print("message recieved" + event.toMap().toString());
//       print(event.notification!.body);
//       print(event.notification!.body);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: ' Admin',
//         debugShowCheckedModeBanner: false,
//         home: AdminLoginScreen());
//   }
// }

// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// Future<void> _requestNotificationPermission() async {
//   _firebaseMessaging.onTokenRefresh.listen((event) {});
//   NotificationSettings settings = await _firebaseMessaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission');
//   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//     print('User granted provisional permission');
//   } else {
//     print('User declined or has not accepted permission');
//   }
// }




import 'dart:math';
import 'package:betappadmin/View/adminLogin.dart';
import 'package:betappadmin/View/splash_screen.dart';
import 'package:betappadmin/constant/notification_services.dart';
import 'package:betappadmin/firebase_options.dart';
import 'package:betappadmin/utills/localdatabase.dart';
import 'package:betappadmin/utills/notificationapi.dart';
import 'package:betappadmin/utills/utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _requestNotificationPermission();
  runApp(
    AdminPanel(),
  );
}

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  NotificationServices notificationServices = NotificationServices();
  bool? type;
  getData() async {
    final a = await LocalDatabase().getData(key: "login");
    setState(() {
      type = a;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Utility.subScribeTopic("all");
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved" + event.toMap().toString());
      print(event.notification!.body);
      print(event.notification!.body);
      int id = Random().nextInt(1000) + 50;
      print("id" + id.toString());
      if (event.data != null && event.data['imageUrl'] != null) {
        NotificationApi.showBigPictureNotificationHiddenLargeIcon(
            event.notification!.title.toString(),
            event.notification!.body.toString(),
            event.data['imageUrl']);
      } else {
        NotificationApi.ShowNotification(
          id: id,
          title: event.notification!.title,
          body: event.notification!.body,
          payload: "",
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('A new onMessageOpenedApp event was published!');
      print("message recieved" + event.toMap().toString());
      print(event.notification!.body);
      print(event.notification!.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: ' Admin',
        debugShowCheckedModeBanner: false,
        home: AdminLoginScreen());
  }
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<void> _requestNotificationPermission() async {
  _firebaseMessaging.onTokenRefresh.listen((event) {});
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
