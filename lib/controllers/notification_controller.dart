import 'package:permission_handler/permission_handler.dart';
import 'package:wear_ongoing_activity/wear_ongoing_activity.dart';

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
    requestPermissions();
  }

  static requestPermissions() async {
    // // TODO: Show permission dialog
    await Permission.notification.request();
  }

  static startOngoingActivity({required Duration timeToStart}) {
    WearOngoingActivity.start(
      channelId: NotificationChannelIdentifier.channelKey.value,
      channelName: NotificationChannelIdentifier.channelName.value,
      notificationId: timerId,
      category: NotificationCategory.alarm,
      foregroundServiceTypes: {
        // Currently not required
        // ForegroundServiceType.location,
      },
      smallIcon: 'icons/regatta_timer_icon_only.png',
      staticIcon: 'icons/regatta_timer_icon_only.png',
      status: OngoingTimerActivityStatus(
        timeToStart: timeToStart,
      ),
    );
  }

  static updateOngoingActivity({required Duration timeToStart}) {
    WearOngoingActivity.update(
      OngoingTimerActivityStatus(
        timeToStart: timeToStart,
      ),
    );
  }

  static cancelTimerNotification() {
    // AwesomeNotifications().cancel(timerId);
    WearOngoingActivity.stop();
  }
}

class OngoingTimerActivityStatus extends OngoingActivityStatus {
  OngoingTimerActivityStatus({required Duration timeToStart})
      : super(
          templates: [
            "Starts in: #time#",
          ],
          parts: [
            TextPart(name: "time", text: "${-timeToStart.inMinutes}:${-timeToStart.inSeconds % 60}"),
          ],
        );
}
