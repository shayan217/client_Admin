import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class NotificationApi{
  var initializationSettingsAndroid = AndroidInitializationSettings('logo1');
  static final notification = FlutterLocalNotificationsPlugin();


  static Future notificationDetails(
      {dynamic styleInformation, dynamic largeIcon}) async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            largeIcon: largeIcon,
            styleInformation: styleInformation,
            // 'channel description',
            importance: Importance.max,
            icon: '@drawable/logo1'),
    //  iOS: IOSNotificationDetails()
    );
  }

  static Future ShowNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    notification.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    // String? _title;
    // String? _body;
    // String _orderID;
    // String? _image;
    // if(data) {
    //   _title = message.data['title'];
    //   _body = message.data['body'];
    //   _orderID = message.data['order_id'];
    //   _image = "";
    // }else {
    //   _title = message.notification!.title;
    //   _body = message.notification!.body;
    //   if(Platform.isAndroid) {
    //     _image = "";
    //   }else if(Platform.isIOS) {
    //     _image = "";
    //   }
    // }
    //
    // if(_image != null && _image.isNotEmpty) {
    //   try{
    //     await showBigPictureNotificationHiddenLargeIcon(_title, _body, _orderID, _image, fln);
    //   }catch(e) {
    //     await showBigTextNotification(_title, _body, _orderID, fln);
    //   }
    // }else {
    //   await showBigTextNotification(_title, _body, _orderID, fln);
    // }
  }

  //i
  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String image,
      ) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
    await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    await notification.show(
      0,
      title,
      body,
      await notificationDetails(
          styleInformation: bigPictureStyleInformation,
          largeIcon:  FilePathAndroidBitmap(largeIconPath)
      ),
    );
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    var response = await get(Uri.parse(
      url,
    ));
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    // final Response response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}


