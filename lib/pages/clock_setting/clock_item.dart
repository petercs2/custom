import 'dart:async';

import 'package:custom_clock/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

class ClockItem extends StatefulWidget {
  const ClockItem(this.selectedIndex, this.currentIndex, this.onTap, {Key? key})
      : super(key: key);
  final int selectedIndex;
  final int currentIndex;
  final Function(int) onTap;

  @override
  State<ClockItem> createState() => _ClockItemState();
}

class _ClockItemState extends State<ClockItem> {
  Timer? _timer;

  var hFirstNum = 0;
  var hLastNum = 0;
  var mFirstNum = 0;
  var mLastNum = 0;

  void startTimer() {
    final currentNow = DateTime.now();
    if (mounted) {
      setState(() {
        final currentHMStr = DateFormat('HH:mm').format(currentNow);
        hFirstNum = int.parse(currentHMStr.substring(0, 1));
        hLastNum = int.parse(currentHMStr.substring(1, 2));
        mFirstNum = int.parse(currentHMStr.substring(3, 4));
        mLastNum = int.parse(currentHMStr.substring(4, 5));
      });
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (mounted) {
        setState(() {
          final hmStr = DateFormat('HH:mm').format(now);
          hFirstNum = int.parse(hmStr.substring(0, 1));
          hLastNum = int.parse(hmStr.substring(1, 2));
          mFirstNum = int.parse(hmStr.substring(3, 4));
          mLastNum = int.parse(hmStr.substring(4, 5));
        });
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: <Widget>[
        <Widget>[
          Image.asset(
            'assets/img${widget.currentIndex}$hFirstNum.webp',
            width: 25.6,
            height: 37,
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/img${widget.currentIndex}$hLastNum.webp',
            width: 25.6,
            height: 37,
            fit: BoxFit.cover,
          )
        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        const SizedBox(
          width: 10,
        ),
        <Widget>[
          Image.asset(
            'assets/img${widget.currentIndex}$mFirstNum.webp',
            width: 25.6,
            height: 37,
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/img${widget.currentIndex}$mLastNum.webp',
            width: 25.6,
            height: 37,
            fit: BoxFit.cover,
          )
        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
    )
        .decorated(
            color: widget.currentIndex == widget.selectedIndex
                ? Colors.black
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10))
        .gestures(onTap: () async {
      widget.onTap(widget.currentIndex);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('type', widget.currentIndex);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stopTimer();
    super.dispose();
  }
}
