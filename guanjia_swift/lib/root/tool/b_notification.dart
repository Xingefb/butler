import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 刷新自选
class RefreshSelectList {
  bool refresh;
  RefreshSelectList(bool refresh) {
    this.refresh = refresh;
  }
}

// 模拟交易
class RefreshMoniList {
  bool refresh;
  RefreshMoniList(bool refresh) {
    this.refresh = refresh;
  }
}

class RefreshNews {
  String text;
  RefreshNews({ String text}) {
    this.text = text;
  }
}

