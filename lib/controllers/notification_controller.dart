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

abstract class NotificationController extends Notifier<bool> {
  final timerId = 32;

  @override
  bool build() => false;

  static Future<void> init() => throw UnimplementedError();

  Future<void> startOngoingActivity({required Duration timeToStart});

  Future<void> updateOngoingActivity({required Duration timeToStart});

  Future<void> cancelTimerNotification();
}

final notificationController = NotifierProvider<OngoingNotificationController, bool>(OngoingNotificationController.new);
