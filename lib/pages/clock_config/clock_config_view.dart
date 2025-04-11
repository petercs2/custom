import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'clock_config_logic.dart';

class ClockConfigView extends GetView<PageLogic> {
  const ClockConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.carter.value
              ? const CircularProgressIndicator(color: Colors.deepPurpleAccent)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.sipmlk();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
