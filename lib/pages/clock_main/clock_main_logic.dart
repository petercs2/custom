import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockMainLogic extends GetxController {

  var type = 0.obs;
  var ymdStr = '-'.obs;
  var hFirstNum = 0.obs;
  var hLastNum = 0.obs;
  var mFirstNum = 0.obs;
  var mLastNum = 0.obs;
  var apmStr = '-'.obs;
  var weekDayStr = '-'.obs;

  Timer? _timer;

  void startTimer() {
    stopTimer();
    final currentNow = DateTime.now();
    ymdStr.value = DateFormat('MMM d . yyyy', 'en_US').format(currentNow).toUpperCase();
    final hmStr = DateFormat('HH:mm').format(currentNow);
    hFirstNum.value = int.parse(hmStr.substring(0, 1));
    hLastNum.value = int.parse(hmStr.substring(1, 2));
    mFirstNum.value = int.parse(hmStr.substring(3, 4));
    mLastNum.value = int.parse(hmStr.substring(4, 5));
    apmStr.value = DateFormat('a').format(currentNow).toUpperCase();
    weekDayStr.value = DateFormat('EEE').format(currentNow).toUpperCase();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      ymdStr.value = DateFormat('MMM d . yyyy', 'en_US').format(now).toUpperCase();
      final hmStr = DateFormat('HH:mm').format(now);
      hFirstNum.value = int.parse(hmStr.substring(0, 1));
      hLastNum.value = int.parse(hmStr.substring(1, 2));
      mFirstNum.value = int.parse(hmStr.substring(3, 4));
      mLastNum.value = int.parse(hmStr.substring(4, 5));
      apmStr.value = DateFormat('a').format(now).toUpperCase();
      weekDayStr.value = DateFormat('EEE').format(now).toUpperCase();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void onRefresh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    type.value = prefs.getInt('type') ?? 0;
    startTimer();
  }

  @override
  void onInit() async {
    super.onInit();
    onRefresh();
  }

}
