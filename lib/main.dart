import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/page/ListGunungPage.dart';
import 'package:flutter_gunungku_com/page/WelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {    
    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return new MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.green,
                primarySwatch: Colors.green,
                //scaffoldBackgroundColor: Color.fromARGB(240, 240, 240, 240)
            ),
            //home: WelcomePage()
            home: ListGunugPage(),
        );
    }
}