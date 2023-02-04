import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;

class ActiveProjectsCard extends StatelessWidget {
  final Color cardColor;
  final double loadingPercent;
  final String title;
  final String subtitle;
  String id;

  ActiveProjectsCard({
    required this.cardColor,
    required this.loadingPercent,
    required this.title,
    required this.subtitle,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        updatee(id);
      }),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        padding: EdgeInsets.all(5.0),
        height: 250,
        width: MediaQuery.of(context).size.width - 10,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularPercentIndicator(
                animation: true,
                radius: 75.0,
                percent: loadingPercent,
                lineWidth: 5.0,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white10,
                progressColor: Colors.white,
                center: Text(
                  '${(loadingPercent * 100).round()}%',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updatee(String id) async {
    await Firebase.initializeApp();

    var url = Uri.parse(
        'https://restfule-api-default-rtdb.firebaseio.com/active/$id.json');

    await http.patch(url,
        body: jsonEncode({
          'percent': 100,
          'title': ' new title',
          'subtitle': 'new subtitle',
        }));
    print('object updated');
    print(id);
  }
}
