//
// import 'package:bpro_app_wallet/constant/accessToken.dart';
// import 'package:dio/dio.dart';
//
// class Connection {
//
//   static const String baseUrl = "https://fcm.googleapis.com/";
//
//
//
//
//   Dio dio = Dio();
//
//   Connection() {
//
//     dio
//       ..options.baseUrl = baseUrl
//       ..options.connectTimeout = 30000
//       ..options.receiveTimeout = 30000
//       ..httpClientAdapter
//       ..options.headers = {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'accept': 'application/json',
//         'Authorization':'key=AAAAr-glD70:APA91bGSdlzU_a7e8ypNVV8UptrLan-iCd4x4zooV1ewjwFOSf9O44chxP_Gea782u5UAZWVBGRcYoa0_94mP-J5pzEHwdHkA6bMvQu2LxSqn4YTeEOMK4xLxRjMuyv3gGfzLP0BM-3e'
//       };
//   }
//
//
//   void send(String title,String message,String id) async {
//
//
//     Map<String,dynamic> data = {
//       "title":title,
//       "body":message,
//     };
//     Map<String,dynamic> notification = {
//       "to":"/topics/$id",
//       "data":data
//     };
//
//
//     Response response = await dio.post("fcm/send", data: notification,);
//     print(response.data.toString());
//
//   }
// }
