import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch_provider.g.dart';

@riverpod
class SwitchNotifier extends _$SwitchNotifier {
//Cualquier producto
  @override
  bool build() {
    return false;
  }

  void updateSwitch(bool currentState) {
    state = currentState;
  }
}
