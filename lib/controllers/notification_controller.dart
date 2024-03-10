import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

enum NotificationChannelIdentifier {
  channelKey(value: "base_channel"),
  channelName(value: "Base Notifications"),
  channelGroupKey(value: "base_channel_group"),
  channelGroupName(value: "Base Channel Group"),
  channelDescription(value: "Notification Channel for Base Notifications"),
  showAppNotificationActionButton(value: "showAppNotificationActionButton");

  const NotificationChannelIdentifier({
    required this.value,
  });

  final String value;
}

class NotificationController {
  static const timerId = 32;

  static void init() {
    AwesomeNotifications().initialize(
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

  static requestPermissions() {
    // TODO: Show permission dialog
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
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
    AndroidForegroundService.startAndroidForegroundService(
        foregroundStartMode: ForegroundStartMode.stick,
        foregroundServiceType: ForegroundServiceType.phoneCall,
        content: NotificationContent(
          id: timerId,
          title: "Regatta Timer",
          body: "Race starts in ${-timeToStart.inMinutes}:${-timeToStart.inSeconds % 60}",
          channelKey: NotificationChannelIdentifier.channelKey.value,
          notificationLayout: NotificationLayout.Default,
          category: NotificationCategory.Alarm,
          locked: true,
          autoDismissible: false,
          actionType: ActionType.Default,
        ),
        actionButtons: [
          NotificationActionButton(
            key: NotificationChannelIdentifier.showAppNotificationActionButton.value,
            label: "Open Regatta Timer",
          )
        ]);

    // AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: timerId,
    //     channelKey: NotificationChannelIdentifier.channelKey.value,
    //     actionType: ActionType.Default,
    //     category: NotificationCategory.StopWatch,
    //     autoDismissible: false,
    //     title: "Regatta Timer",
    //     body: "Race starts in ${-timeToStart.inMinutes}:${-timeToStart.inSeconds % 60}",
    //     locked: true,
    //   ),
    // );
  }

  static cancelTimerNotification() {
    AndroidForegroundService.stopForeground(timerId);
    // AwesomeNotifications().cancel(timerId);
  }
}
