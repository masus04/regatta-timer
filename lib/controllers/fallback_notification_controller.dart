import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';
import 'package:regatta_timer/providers/timer_providers.dart';

class FallbackNotificationController extends NotificationController {
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

    await requestPermissions();
  }

  static requestPermissions() async {
    if (!await AwesomeNotifications().isNotificationAllowed()) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  @override
  Future<void> startOngoingActivity({required Duration timeToStart}) async {
    if (!state) {
      await setListeners();
      state = true;
    }
  }

  @override
  Future<void> updateOngoingActivity({required Duration timeToStart}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: timerId,
        channelKey: NotificationChannelIdentifier.channelKey.value,
        actionType: ActionType.Default,
        category: NotificationCategory.StopWatch,
        autoDismissible: false,
        title: "Regatta Timer",
        body: timeToStart.isNegative ? "Race timer: ${timeToStart.format()}": "Race starts in ${timeToStart.format()}",
        locked: true,
      ),
    );
  }

  static Future<void> setListeners() async {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: FallbackNotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: FallbackNotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: FallbackNotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: FallbackNotificationController.onDismissActionReceivedMethod,
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

  @override
  Future<void> cancelTimerNotification() async {
    await AwesomeNotifications().cancel(timerId);
  }
}
