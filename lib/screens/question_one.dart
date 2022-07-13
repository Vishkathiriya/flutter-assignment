import 'package:flutter/material.dart';
import 'package:flutter_home_assignment/bloc/bottom_tab_bar_class.dart';
import 'package:flutter_home_assignment/providers/questions.dart';
import 'package:flutter_home_assignment/widget/appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../model/question_model.dart';

class QuestionOne extends StatefulWidget {
  const QuestionOne({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne> {
  int score = 0;
  int? selectedIndex;
  bool isAnslock = false;
  var randomQuelist = [];
  int? qListIndex;

  @override
  Widget build(BuildContext context) {
    // use for fatch data from provider
    return ChangeNotifierProvider(
      create: (context) => Questions(),
      child: Scaffold(
        body: StreamBuilder<int>(
          stream: updateValueBloc.indexControllerStrme,
          initialData: 0,
          builder: (context, AsyncSnapshot<int> indexSnapshot) {
            if (indexSnapshot.data! < context.read<Questions>().items.length) {
              context
                  .read<Questions>()
                  .items[indexSnapshot.data!]
                  .incorrect!
                  .add(context
                      .read<Questions>()
                      .items[indexSnapshot.data!]
                      .correct!);
              randomQuelist = (context
                  .read<Questions>()
                  .items[indexSnapshot.data!]
                  .incorrect!
                ..shuffle());
            }
            return Column(
              children: [
                progressTimerWidget(
                    indexSnapshot.data!, context.read<Questions>().items),
                Image.asset(
                  'assets/images/mind.png',
                  scale: 1,
                  height: MediaQuery.of(context).size.height / 3,
                ),
                questionListWidget(context.read<Questions>().items),
              ],
            );
          },
        ),
      ),
    );
  }

  //====================== All Question List Widget ============================ //

  Widget questionListWidget(List<Question> items) {
    return StreamBuilder<int>(
      stream: updateValueBloc.indexControllerStrme,
      initialData: 0,
      builder: (context, AsyncSnapshot<int> indexSnapshot) {
        return indexSnapshot.data! < items.length
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Text(
                      items[indexSnapshot.data!].text ?? '',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  questionList(indexSnapshot, items),
                ],
              )
            : Text(
                'Thank You for Play \n\nYour Todat Score is : $score',
                textAlign: TextAlign.center,
              );
      },
    );
  }

  //====================== Progress Indicator Widget ============================ //

  Widget progressTimerWidget(int snapshotIndex, List<Question> items) {
    // App bar widget to use everywhere in App
    return Appbar(
      score: score,
      snapshotIndex: snapshotIndex,
      visibility: snapshotIndex < items.length ? true : false,
      onAnimationEnd: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 800),
            content: Text(
              'opps! Time Uppp!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );

        Future.delayed(
          const Duration(milliseconds: 1200),
          () {
            setState(() {});
            isAnslock = false;
            selectedIndex = null;
            updateValueBloc.indexSink(snapshotIndex + 1);
          },
        );
      },
    );
  }

  //====================== Question List Widget ============================ //

  Widget questionList(AsyncSnapshot<int> indexSnapshot, List<Question> items) {
    return StreamBuilder<bool>(
      stream: updateValueBloc.flagController,
      initialData: false,
      builder: (context, AsyncSnapshot<bool> flagSnapshot) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: randomQuelist.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (indexSnapshot.data! < items.length) {
                  if (!isAnslock) {
                    isAnslock = true;
                    selectedIndex = index;
                    updateValueBloc.flagSink(true);
                    Future.delayed(
                        const Duration(seconds: 1),
                        () => checkAns(items[indexSnapshot.data!].correct!,
                            randomQuelist[index], indexSnapshot.data!));
                  }
                }
              },
              child: Container(
                height: 45.h,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Center(
                  child: Text(randomQuelist[index],
                      style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), //Use this code to make rounded corners
                  color: selectedIndex == index
                      ? Colors.amber
                      : Colors.indigoAccent,
                ),
              ),
            );
          },
        );
      },
    );
  }

//====================== Check Selected Ans Method ============================ //

  void checkAns(String selectedAns, String? correct, int snapshotIndex) {
    if (selectedAns == correct) {
      score = score + 100;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 800),
        backgroundColor: Colors.green,
        content: Text(
          'Yeh! Answer is Correct!',
          style: TextStyle(color: Colors.white),
        ),
      ));

      //  updateValueBloc.indexSink(snapshotIndex + 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 800),
        content: Text(
          'opps! Answer is Incorrect!',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {});
      isAnslock = false;
      selectedIndex = null;
      updateValueBloc.indexSink(snapshotIndex + 1);
    });
  }

  @override
  void dispose() {
    // use for dispose bloc controller value
    updateValueBloc.dipose();
    super.dispose();
  }
}
