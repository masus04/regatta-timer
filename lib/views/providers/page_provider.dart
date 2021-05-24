import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../set_timer_view.dart';

// TODO: Remove unused

final pageProvider = StateProvider<List<Page>>((ref) {
  var setTimerPage = const MaterialPage(
    child: SetTimerView(
      key: Key('SetTimerView'),
    ),
  );

  return [
    setTimerPage,
  ];
});

// ---------------------------------------------------------------------------

typedef PagesList = List<Page>;

class PageNotifier extends StateNotifier<PagesList> {
  PageNotifier(List<Page> pages) : super(pages);

  void add(Page page) {
    state = [...state, page];
  }

  void removeLast() {
    state = state.sublist(0, state.length-1);
  }
}

final pageNotifierProvider = StateNotifierProvider<PageNotifier, PagesList>(
  (ref) => PageNotifier(
    [
      const MaterialPage(
        child: SetTimerView(
          key: Key('SetTimerView'),
        ),
        key: ValueKey('SetTimerView'),
        name: 'SetTimerView',
        fullscreenDialog: true,
        maintainState: true,
      ),
    ],
  ),
);

// ---------------------------------------------------------------------------

class PageChangeNotifier extends ChangeNotifier {
  List<Page> pages = [
    const MaterialPage(
        child: SetTimerView(
          key: Key('SetTimerView'),
        ),
        key: ValueKey('SetTimerView'))
  ];

  void add(Page page) {
    pages = [...pages, page];
    notifyListeners();
  }

  void removeLast(Page page) {
    pages.removeLast();
    notifyListeners();
  }
}

final pageChangeNotifierProvider =
    ChangeNotifierProvider((ref) => PageChangeNotifier());
