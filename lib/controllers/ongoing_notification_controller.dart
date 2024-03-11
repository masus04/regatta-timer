import 'package:permission_handler/permission_handler.dart';
import 'package:regatta_timer/controllers/notification_controller.dart';
import 'package:wear_ongoing_activity/wear_ongoing_activity.dart';

class OngoingNotificationController {
  static Future<void> requestPermissions() async {
    // // TODO: Show permission dialog
    await Permission.notification.request();
  }

  static Future<void> startOngoingActivity({required Duration timeToStart, required int notificationId}) async {
    await WearOngoingActivity.start(
      channelId: NotificationChannelIdentifier.channelKey.value,
      channelName: NotificationChannelIdentifier.channelName.value,
      notificationId: notificationId,
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
  }

  static Future<void> updateOngoingActivity({required Duration timeToStart}) async {
    await WearOngoingActivity.update(
      OngoingTimerActivityStatus(
        timeToStart: timeToStart,
      ),
    );
  }

  static Future<void> cancelTimerNotification() async {
    await WearOngoingActivity.stop();
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
            TextPart(
                name: "time",
                text: timeToStart == Duration.zero ? "" : "${-timeToStart.inMinutes}:${(-timeToStart.inSeconds % 60).toString().padLeft(2, '0')}"),
          ],
        );
}
