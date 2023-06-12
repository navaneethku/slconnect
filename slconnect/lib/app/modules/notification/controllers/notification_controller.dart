import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController

  final count = 0.obs;
  void sendPushNotification(
      String recipientDeviceToken, String notificationMessage) async {
    var notification = OSCreateNotification(
      playerIds: [recipientDeviceToken],
      content: notificationMessage,
    );

    var response = await OneSignal.shared.postNotification(notification);

    if (response.containsKey('status')) {
      var status = response['status'];
      if (status == 'success') {
        debugPrint('Push notification sent successfully!');
      } else {
        debugPrint(
            'Failed to send push notification. Error: ${response.toString()}');
      }
    } else {
      debugPrint(
          'Failed to send push notification. Invalid response: ${response.toString()}');
    }
  }


  void increment() => count.value++;
}
