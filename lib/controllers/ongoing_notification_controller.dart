import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';
import 'package:regatta_timer/providers/timers_v3.dart';
import 'package:wear_ongoing_activity/wear_ongoing_activity.dart';

class OngoingNotificationController extends NotificationController {
  static Future<void> init() async {
    await OngoingNotificationController.requestPermissions();
  }

  static Future<void> requestPermissions() async {
    // // TODO: Show permission dialog
    await Permission.notification.request();
  }

  @override
  Future<void> startOngoingActivity({required Duration timeToStart}) async {
    if (!state) {
      await WearOngoingActivity.start(
        channelId: NotificationChannelIdentifier.channelKey.value,
        channelName: NotificationChannelIdentifier.channelName.value,
        notificationId: timerId,
        category: NotificationCategory.alarm,
        foregroundServiceTypes: {
          // Currently not required
          // ForegroundServiceType.location,
        },
        smallIcon: 'splash',
        staticIcon: 'splash',
        status: OngoingTimerActivityStatus(
          timeToStart: timeToStart,
        ),
      );

      state = true;
    }
  }

  @override
  Future<void> updateOngoingActivity({required Duration timeToStart}) async {
    if (state) {
      await WearOngoingActivity.update(
        OngoingTimerActivityStatus(
          timeToStart: timeToStart,
        ),
      );
    } else {
      debugPrint("Cannot update Ongoing Activity, none are currently running.");
    }
  }

  @override
  Future<void> cancelTimerNotification() async {
    if (state) {
      await WearOngoingActivity.stop();

      state = false;
    }
  }
}

class OngoingTimerActivityStatus extends OngoingActivityStatus {
  OngoingTimerActivityStatus({required Duration timeToStart})
      : super(
          templates: [
            "#text#"
                "#time#",
          ],
          parts: [
            TextPart(name: "text", text: timeToStart == Duration.zero ? "" : "Starts in: "),
            TextPart(name: "time", text: timeToStart == Duration.zero ? "" : timeToStart.format()),
          ],
        );
}
