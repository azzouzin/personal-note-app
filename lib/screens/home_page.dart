import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/calendar_page.dart';
import '../statemanagment/statemanage.dart';
import '../theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widgets/task_column.dart';
import '../widgets/active_project_card.dart';
import '../widgets/top_container.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Statemanage _taskcontroller = Statemanage();
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  List<ActiveProjectsCard> objects = [];
  @override
  Widget build(BuildContext context) {
    Statemanage controller = Get.put(Statemanage());

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => getinfo(),
          child: Center(
              child: Column(
            children: [
              TopContainer(
                height: 300,
                width: width,
                padding: EdgeInsets.zero,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.menu,
                              color: LightColors.kDarkBlue, size: 30.0),
                          Icon(Icons.search,
                              color: LightColors.kDarkBlue, size: 25.0),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircularPercentIndicator(
                              radius: 90.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: 0.75,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: LightColors.kRed,
                              backgroundColor: LightColors.kDarkYellow,
                              center: CircleAvatar(
                                backgroundColor: LightColors.kBlue,
                                radius: 35.0,
                                backgroundImage: AssetImage(
                                  'lib/assets/images/avatar.png',
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Merouani Azzouz',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: LightColors.kDarkBlue,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'App Developer',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                subheading('My Tasks'),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CalendarPage()),
                                    );
                                  },
                                  child: Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            GestureDetector(
                              onTap: () {
                                Get.to(CalendarPage());
                              },
                              child: TaskColumn(
                                icon: Icons.alarm,
                                iconBackgroundColor: LightColors.kRed,
                                title: 'To Do',
                                subtitle: '5 tasks now. 1 started',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TaskColumn(
                              icon: Icons.blur_circular,
                              iconBackgroundColor: LightColors.kDarkYellow,
                              title: 'In Progress',
                              subtitle: '1 tasks now. 1 started',
                            ),
                            SizedBox(height: 15.0),
                            TaskColumn(
                              icon: Icons.check_circle_outline,
                              iconBackgroundColor: LightColors.kBlue,
                              title: 'Done',
                              subtitle: '18 tasks now. 13 started',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            subheading('Active Projects'),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                      ...objects
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> getinfo() async {}
}
