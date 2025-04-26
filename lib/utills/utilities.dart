import 'package:firebase_messaging/firebase_messaging.dart';

class Utility{
  static void subScribeTopic(String topic){
    print("subtopic"+topic);
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }
  static void unSubTopic(String topic){
    print("unsubtopic"+topic);

    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
}