import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gunungku_com/Config.dart';
import 'package:flutter_gunungku_com/page/ListGunungPage.dart';
import 'package:flutter_gunungku_com/page/WelcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
    String apiUrl = 'http://192.168.43.156/gunungku.com/web';

    WidgetsFlutterBinding.ensureInitialized();
    //final String jsonConfig = await rootBundle.loadString('assets/config.json');
    //Config config = Config.fromJson(jsonDecode(jsonConfig));
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('apiUrl', apiUrl);

    return runApp(
        new MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.green,
                primarySwatch: Colors.green,
                //scaffoldBackgroundColor: Color.fromARGB(240, 240, 240, 240)
            ),
            //home: WelcomePage()
            home: ListGunugPage(),
        )
    );
}