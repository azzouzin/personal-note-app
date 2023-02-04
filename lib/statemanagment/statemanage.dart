import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../widgets/active_project_card.dart';
import 'dart:math' as math;

import '../theme/colors/light_colors.dart';

class Statemanage extends GetxController {
  RxList objects = [
    ActiveProjectsCard(
      id: '2',
      cardColor: LightColors.kGreen,
      loadingPercent: 0.25,
      title: 'Medical App',
      subtitle: '9 hours progress',
    ),
  ].obs;
  RxString txt = ''.obs;

  void updatet(ActiveProjectsCard activeProjectsCard) {
    objects.add(activeProjectsCard);
    print(objects.length);
  }

  void initstat() {}

  void getinfo() async {
    await Firebase.initializeApp();
    txt = RxString('This is button ');
    try {
      var url = Uri.parse(
          'https://restfule-api-default-rtdb.firebaseio.com/active.json');

      var res = await http.get(url);
      final exctracteddata = jsonDecode(res.body) as Map<String, dynamic>;

      exctracteddata.forEach((id, item) {
        objects.add(ActiveProjectsCard(
            cardColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),
            loadingPercent: item['percent'],
            title: item['title'],
            subtitle: item['subtitle'],
            id: id));
        notifyChildrens();
      });
      objects.forEach((element) {
        print('------------------------------');
        print(element.id);
      });
    } on Exception catch (_) {
      rethrow;
      // TODO
    } finally {
      objects.refresh();
    }
  }
}
