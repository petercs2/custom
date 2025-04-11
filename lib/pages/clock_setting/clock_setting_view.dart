import 'package:custom_clock/pages/clock_setting/clock_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'clock_setting_logic.dart';

class ClockSettingPage extends GetView<ClockSettingLogic> {
  const ClockSettingPage({super.key});

  Widget _item(int index, BuildContext context) {
    final titles = ['About us'];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(
          titles[index],
          style: const TextStyle(color: Colors.white),
        ),
        const Text(
          "1.0.0",
          style: TextStyle(color: Colors.grey),
        )
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                const Text(
                  'Select style and color',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 35,
                  color: Colors.grey.withOpacity(0.3),
                ),
                SizedBox(
                  child: GetBuilder<ClockSettingLogic>(builder: (_) {
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 151 / 55),
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return ClockItem(controller.type, index, (v) {
                            controller.type = v;
                            controller.update();
                          });
                        });
                  }),
                )
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ).decorated(
                color: const Color(0xff333333).withOpacity(0.59),
                borderRadius: BorderRadius.circular(12)),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[_item(0, context)].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: const Color(0xff333333).withOpacity(0.59),
                borderRadius: BorderRadius.circular(12)),
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
