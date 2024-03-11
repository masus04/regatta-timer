import 'package:hooks_riverpod/hooks_riverpod.dart';
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

class NotificationController extends Notifier<bool> {
  static const timerId = 32;

  @override
  bool build() {
    return false;
  }

  static Future<void> init() async {
    await requestPermissions();
  }

  static Future<void> requestPermissions() async {
    // // TODO: Show permission dialog
    await Permission.notification.request();
  }

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

  Future<void> updateOngoingActivity({required Duration timeToStart}) async {
    await WearOngoingActivity.update(
      OngoingTimerActivityStatus(
        timeToStart: timeToStart,
      ),
    );
  }

  Future<void> cancelTimerNotification() async {
    if (state) {
      await WearOngoingActivity.stop();
      state = false;
    }
    // await updateOngoingActivity(timeToStart: Duration.zero);
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

final notificationController = NotifierProvider<NotificationController, bool>(NotificationController.new);
