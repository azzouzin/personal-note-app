import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../statemanagment/statemanage.dart';
import '../theme/colors/light_colors.dart';
import '../widgets/active_project_card.dart';
import '../widgets/top_container.dart';
import '../widgets/back_button.dart';
import '../widgets/my_text_field.dart';
import '../screens/home_page.dart';
import 'package:http/http.dart' as http;

class CreateNewTaskPage extends StatefulWidget {
  @override
  State<CreateNewTaskPage> createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  TextEditingController title = TextEditingController(),
      date = TextEditingController(),
      start = TextEditingController(),
      end = TextEditingController(),
      desc = TextEditingController();
  int selctedid = 0;

  final Statemanage controller = Get.put(Statemanage());

  @override
  Widget build(BuildContext context) {
    Get.put(Statemanage());

    ;
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () => Get.back(), child: Text('back'))],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              height: 30,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Create new task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(
                        title,
                        label: 'Title',
                        icon: const Icon(Icons.input),
                        maxLines: 1,
                        minLines: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                              date,
                              label: 'Date',
                              icon: downwardIcon,
                              maxLines: 1,
                              minLines: 1,
                            ),
                          ),
                          HomePage.calendarIcon(),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                        start,
                        maxLines: 1,
                        minLines: 1,
                        label: 'Start Time',
                        icon: downwardIcon,
                      )),
                      const SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          end,
                          maxLines: 1,
                          minLines: 1,
                          label: 'End Time',
                          icon: downwardIcon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    desc,
                    icon: const Icon(Icons.input),
                    label: 'Description',
                    minLines: 3,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          //textDirection: TextDirection.rtl,
                          spacing: 10.0,
                          children: <Widget>[
                            chipchip(Text("SPORTS"), 0),
                            chipchip(Text("STADY"), 1),
                            chipchip(Text("FANTSY"), 2),
                            chipchip(Text("SLEEP"), 3),
                            chipchip(Text("GAMING PLATFORM APP"), 4),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      var a = ActiveProjectsCard(
                          id: '',
                          cardColor: Colors.black,
                          loadingPercent: Random().nextDouble(),
                          title: title.text,
                          subtitle: desc.text);

                      saves(a, context);
                    },
                    child: Container(
                      child: const Text(
                        'Create Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: LightColors.kBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  saves(ActiveProjectsCard a, BuildContext ctx) async {
    print('save printd');
  }

  GestureDetector chipchip(Text t, int iclr) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selctedid = iclr;
        });
      },
      child: Chip(
        label: t,
        backgroundColor: selctedid == iclr ? LightColors.kRed : Colors.grey,
      ),
    );
  }
}
