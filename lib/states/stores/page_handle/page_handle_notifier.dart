import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_handle_notifier.g.dart';

@riverpod
class PageHandleNotifier extends _$PageHandleNotifier {
  @override
  int build() => 0;

  void set(int value) {
    state = value;
  }
}
