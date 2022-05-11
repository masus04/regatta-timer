import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:regatta_timer/providers/app_lock_provider.dart';
import 'package:regatta_timer/providers/timer_provider_v2.dart';
import 'package:regatta_timer/views/timer/post_start_view.dart';
import 'package:regatta_timer/views/timer/pre_start_view.dart';

class TimerView extends HookConsumerWidget {
  const TimerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeProvider = ref.watch(currentTimeProvider);
    final screenLocked = ref.watch(appLockedProvider);

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          IgnorePointer(
            ignoring: screenLocked,
            child: timeProvider.when(
              data: (time) => time.isNegative
                  ? const PreStartView()
                  : const PostStartView(),
              error: (err, stackTrace) => Text(err.toString()),
              loading: () => const PreStartView(),
            ),
          ),
          const LockScreenButton()
        ],
      ),
    );
  }
}

class LockScreenButton extends HookConsumerWidget {
  const LockScreenButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScreenLocked = ref.watch(appLockedProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 1),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: IconButton(
            onPressed: onLockScreenPressed(context, ref),
            icon: Icon(
              isScreenLocked ? Icons.lock : Icons.lock_open,
              size: 18,
            ),
            constraints: BoxConstraints.tight(const Size.fromRadius(18)),
          ),
        ),
      ),
    );
  }

  void Function() onLockScreenPressed(BuildContext context, WidgetRef ref) {
    return () {
      ref.watch(appLockedProvider.notifier).toggle();
    };
  }
}
