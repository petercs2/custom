import 'package:get/get.dart';

import 'clock_config_logic.dart';

class ClockConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
