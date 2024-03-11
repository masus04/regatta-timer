import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/controllers/ongoing_notification_controller.dart';

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
    await OngoingNotificationController.requestPermissions();
  }

  Future<void> startOngoingActivity({required Duration timeToStart}) async {
    if (!state) {
      await OngoingNotificationController.startOngoingActivity(timeToStart: timeToStart, notificationId: timerId);
      state = true;
    }
  }

  Future<void> updateOngoingActivity({required Duration timeToStart}) async {
    await OngoingNotificationController.updateOngoingActivity(timeToStart: timeToStart);
  }

  Future<void> cancelTimerNotification() async {
    if (state) {
      await OngoingNotificationController.cancelTimerNotification();
      state = false;
    }
  }
}

final notificationController = NotifierProvider<NotificationController, bool>(NotificationController.new);
