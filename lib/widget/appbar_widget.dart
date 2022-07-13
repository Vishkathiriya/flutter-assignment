import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Appbar extends StatelessWidget {
  final void Function()? onAnimationEnd;
  final int? score;
  final int? snapshotIndex;
  final bool? visibility;
  const Appbar(
      {Key? key,
      this.onAnimationEnd,
      this.score,
      this.snapshotIndex,
      this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 30.h, left: 10.h, right: 10.h, bottom: 7.h),
          child: Builder(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.grey,
                ),
                Stack(children: [
                  Image.asset(
                    'assets/images/score.jpg',
                    width: 90.w,
                  ),
                  Positioned(
                    child: Text(
                      '$score',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    top: 6,
                    left: 45,
                  )
                ])
              ],
            );
          }),
        ),

        // This widget is show horizontal timer indicator.

        Visibility(
          visible: visibility!,
          child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              // ignore: deprecated_member_use
              linearStrokeCap: LinearStrokeCap.roundAll,
              lineHeight: 2.0,
              restartAnimation: true,
              percent: 1,
              animation: true,
              animationDuration: 30000,
              backgroundColor: Colors.grey,
              progressColor: Colors.lightGreenAccent,
              onAnimationEnd: onAnimationEnd),
        ),
        const SizedBox(height: 10),
        Visibility(
            visible: visibility!,
            child: Text('Question ${snapshotIndex! + 1}')),
        Image.asset(
          'assets/images/mind.png',
          scale: 1,
          height: MediaQuery.of(context).size.height / 3,
        )
      ],
    );
  }
}
