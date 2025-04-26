import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:googleapis_auth/auth_io.dart'as auth;
import 'package:http/http.dart'as http;


class AccessToken{
  var tokenA='';
  getFcmToken() {
    FirebaseMessaging.instance.getToken().then((token) {
      print("fcm =  $token");
      tokenA=token.toString();


    });
  }

  Future<String> getAccessToken() async{
    getFcmToken();
    final serviceAccountJson=   {
      "type": "service_account",
      "project_id": "bankapp-853f5",
      "private_key_id": "e8aa1e91a568e59e5a7716474443916bd2960670",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCmJJrq4OlWiHvd\nWameBljdSYizD+ocM65JkaWJIgP1ZM5lPzZDdIbb3L0N7kAqy7611DPoGJCDdAiK\n+Z/46L+nGSN4FutypPjQ3C9DgfH+wpVlU5MkLlNNK3ZFw015VdoKNPATZ/kKR8nB\nHgy4ZFFm/EHZ4PugSGFQd8n0jQDsd8uBvsdOrSEx58ImupgDx133UtFwh5YGDthc\n3LBKTSyM8iOSRlCA+R9ZGvXKJIHEKn/UqPVBC0X5AYk0b5j4nyG2AV0h0JzqQfw+\n/qEUqHprA0IKC2YyY9oq+7OZ2hp1hD8s9zw4/g62O8HozAsRHYflvM65LqSezUgN\n8d7izYA/AgMBAAECggEATl7B/L1vE/R5iSY8TmBsFqYTJ3QAWKFAO0/Kp+81stGE\nUloI/LTA0IFFZIbYGdfV8+tPONItiPR4+yVZAo63qNjA1GrrUT7kZ5EVcmCfiC69\nTfioVc7MWICB39KKfwuyOFJUVLMc1G6cis3j7i7T/yJK5b2stCSwUsbOqt7Aasor\nsbkXSqEoiO7kkPaGwEn+lfTLGRYm/aAUvi6p/1/F06IkRS5FyLQ66OaDQHsk8ZI1\nGuals21BIos1i9e0xUOBMKRt5yn4TmBFeullnNfpdGBJfYO8jfwY+jTpma1L+jTf\nPeSoKSGqF2MYDeLz5yta1Ief3s5wSqaIjgjbWPD4IQKBgQDlppSicCPSS3neA1+N\nkJlLSZAPuFa60yri07XViKZmwTBvP8C+7HK5dbrKliGt+fISAX1L1sv8WtOZ2bOg\n5OXFaUltdPoppKJ88FXjHEM493RQGnwTbNHUff8YqDU8AKMi1cky3oNz7wnS+FEW\nGqD6xOHYUdTqRyjo+dq9Lcn+GQKBgQC5NKSctvt+e3FoDmVDEaPFu1SLP3Fl5DY0\nDi7rM8hZv/b4BGTZv+aktyBnTHhOjwSeAueNtMCIifRMV36JBTJkdqxjUJ8BPTzj\nTJ1gSw+PnzwWCvGAs2E9J/pFh0ZinAZpvs9AV13gNtSHIwC7AtkVZuz6jqZVwHki\naCoRNoKMFwKBgQCHgGOg+MPaGFiey6S8tb4NcylCbUUXVPOwBLT8enWcmY7HhXln\n7cG/dhyx3iWfLqRLRX+1mNahXsINvCtF2ulMMtR1dhkJKzAIwhIbQBjV6wRBI29k\nUsf4NiOnW9CVR9b5/eSKVEqBxGAqkAPgI/QqIrMTXS1g0n3sAUi0aOkPOQKBgQCW\nEUjczwvjRcTzis6UVMO+IXd0yThqVktxTJjJ7hCGYJyOBIlvQyZxCw2Phg/pn8se\n+b2EPhTPzfCMt0yJXBOkAeDXLGlaiLNAfkD62HdIab83ITDklvTQqAcLtXvbxQ8R\nOhIW0XP4jJUS1tLttXYO+HJG57VxwF6m+X40qlWHiwKBgF5UVMVj1hOyu7ymiTFS\nYITK4kKd6qgSLkJSo2rZsBlQwze2JPAXc2NB6qyrcnRhFxdT+8J0+EmCPd5AZCY2\n2AqCMqtJJqv0uhk3SDpL3L1LDsTgXpnRE74yHhSsimZFtasZhv6v2zs+9taADGVC\nq07x64eE+hQbIf4k4Oyv0av0\n-----END PRIVATE KEY-----\n",
      "client_email": "bank-app@bankapp-853f5.iam.gserviceaccount.com",
      "client_id": "103205921929558996285",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bank-app%40bankapp-853f5.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String>scopes=[
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/userinfo.email",

    ];
    http.Client client=await auth.clientViaServiceAccount(auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
    auth.AccessCredentials credentials=
    await auth.obtainAccessCredentialsViaServiceAccount(auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes, client);

    client.close();
    return credentials.accessToken.data;
  }

  void sendNotification(String deviceToken,BuildContext context)async{

    final String serverKey=await getAccessToken();
    print(serverKey);
    String cloudMessaging="https://fcm.googleapis.com/v1/projects/bankapp-853f5/messages:send";
    final Map<String,dynamic> message=
    {
      "message":{
        "token":"$tokenA",
        "notification":{
          "body":"This is an FCM notification message!",
          "title":"FCM Message"
        }
      }

    };
    final response = await http.post(Uri.parse(cloudMessaging),
        headers: {
          'Content-type': 'application/json',

          'Authorization': 'Bearer $serverKey',
        },
        body: jsonEncode(message)


    );
    if(response.statusCode==200){
      print("Notification Sent");
    }
    else{
      print("Notification Not Sent");
    }
  }
}