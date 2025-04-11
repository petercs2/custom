import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'clock_main_logic.dart';

class ClockMainPage extends StatefulWidget {
  const ClockMainPage({Key? key}) : super(key: key);

  @override
  State<ClockMainPage> createState() => _ClockMainPageState();
}

class _ClockMainPageState extends State<ClockMainPage> {
  ClockMainLogic controller = Get.find();

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.toNamed('/notFound');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: <Widget>[
        <Widget>[
          Obx(() {
            return Image.asset(
              'assets/icon${controller.type}.webp',
              width: 22,
              height: 22,
              fit: BoxFit.cover,
            ).gestures(onTap: () {
              Get.toNamed('/clockSetting',
                      arguments: controller.type.value)
                  ?.then((_) {
                controller.onRefresh();
              });
            });
          }),
          Obx(() {
            return Text(
              controller.ymdStr.value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: colorList[controller.type.value]),
            );
          }),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        <Widget>[
          <Widget>[
            Obx(() {
              return Image.asset(
                'assets/img${controller.type.value}${controller.hFirstNum.value}.webp',
                width: 135,
                height: 195,
                fit: BoxFit.cover,
              );
            }),
            Obx(() {
              return Image.asset(
                'assets/img${controller.type.value}${controller.hLastNum.value}.webp',
                width: 135,
                height: 195,
                fit: BoxFit.cover,
              );
            }),
          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
          const SizedBox(
            height: 68,
          ),
          <Widget>[
            Obx(() {
              return Image.asset(
                'assets/img${controller.type.value}${controller.mFirstNum.value}.webp',
                width: 135,
                height: 195,
                fit: BoxFit.cover,
              );
            }),
            Obx(() {
              return Image.asset(
                'assets/img${controller.type.value}${controller.mLastNum.value}.webp',
                width: 135,
                height: 195,
                fit: BoxFit.cover,
              );
            }),
          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        ].toColumn(),
        Align(
          alignment: Alignment.centerLeft,
          child: <Widget>[
            Obx(() {
              return Text(
                controller.apmStr.value,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 39,
                    color: colorList[controller.type.value]),
              );
            }),
            Obx(() {
              return Text(
                controller.weekDayStr.value,
                style: TextStyle(
                    fontSize: 24, color: colorList[controller.type.value]),
              );
            })
          ].toColumn(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start),
        )
      ]
              .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
              .marginAll(26)),
    );
  }
}
