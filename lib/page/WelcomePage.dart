import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/page/ListGunungPage.dart';
import 'package:flutter_gunungku_com/page/LoginPage.dart';
import 'package:flutter_gunungku_com/page/SignUpPage.dart';

class WelcomePage extends StatefulWidget {
    @override 
    _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
    Widget _submitButton() {
        return InkWell(
             onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                    boxShadow: <BoxShadow> [
                        BoxShadow(
                            color: Colors.greenAccent.withAlpha(100),
                            offset: Offset(2, 4),
                            blurRadius: 8,
                            spreadRadius: 2
                        )
                    ],
                ),
                child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: Colors.green)
                ),
            ),
        );
    }

    Widget _signUpButton() {
        return InkWell(
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                    'Registrasi Now',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                ),
            ),
        );
    }

    Widget _label() {
        return Container(
            margin: EdgeInsets.only(top: 40, bottom: 20),
            child: Column(
            children: <Widget>[
                Text(
                    'Quick login with Touch ID',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(
                    height: 20,
                ),
                Icon(Icons.fingerprint, size: 90, color: Colors.white),
                SizedBox(
                    height: 20,
                ),
                Text(
                    'Touch ID',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                    ),
                ),
            ],
        ));
    }

    Widget _title() {
        return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'd',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                ),
                children: [
                    TextSpan(
                        text: 'ev',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    TextSpan(
                        text: 'rnz',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                ]),
        );
    }
    

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
        return Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.green, Colors.greenAccent]
                        )
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            _title(),
                            SizedBox(height: 80),
                            _submitButton(),
                            SizedBox(height: 20),
                            _signUpButton(),
                            SizedBox(height: 20),
                            _label()
                        ],
                    ),
                ),
            ),
        );
    }
}