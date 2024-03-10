import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

enum NotificationChannelIdentifier {
  channelKey(value: "base_channel"),
  channelName(value: "Base Notifications"),
  channelGroupKey(value: "base_channel_group"),
  channelGroupName(value: "Base Channel Group"),
  channelDescription(value: "Notification Channel for Base Notifications");

  const NotificationChannelIdentifier({
    required this.value,
  });

  final String value;
}

class NotificationController {
  static const timerId = 32;

  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      "resource://drawable/splash",
      [
        NotificationChannel(
          channelKey: NotificationChannelIdentifier.channelKey.value,
          channelGroupKey: NotificationChannelIdentifier.channelGroupKey.value,
          channelName: NotificationChannelIdentifier.channelName.value,
          channelDescription: NotificationChannelIdentifier.channelDescription.value,
          defaultColor: const Color(0xFF0000A0),
          ledColor: Colors.white,
          importance: NotificationImportance.Default,
          enableLights: false,
          enableVibration: false,
          playSound: false,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: NotificationChannelIdentifier.channelGroupKey.value,
          channelGroupName: NotificationChannelIdentifier.channelGroupName.value,
        )
      ],
      debug: false,
    );
  }

  static setListeners() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
  }

  static requestPermissions() async {
    // TODO: Show permission dialog
    if (!await AwesomeNotifications().isNotificationAllowed()) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

  static showTimerNotification({required Duration timeToStart}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: timerId,
        channelKey: NotificationChannelIdentifier.channelKey.value,
        actionType: ActionType.Default,
        category: NotificationCategory.StopWatch,
        autoDismissible: false,
        title: "Regatta Timer",
        body: "Race starts in ${-timeToStart.inMinutes}:${-timeToStart.inSeconds % 60}",
        locked: true,
      ),
    );
  }

  static cancelTimerNotification() {
    AwesomeNotifications().cancel(timerId);
  }
}
