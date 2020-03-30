import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    // TODO: implement build
        return Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                    DrawerHeader(
                        decoration: BoxDecoration(
                            color: Colors.green
                        ),
                        child: Text(
                            'Drawer Header',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24
                            ),
                        ),
                    ),
                    ListTile(
                        leading: Icon(Icons.list), 
                        title: Text('Daftar Gunung'), 
                    ),
                    Divider(),
                    ListTile(
                        leading: Icon(Icons.account_circle), 
                        title: Text('Profil'), 
                    ),
                    ListTile(
                        leading: Icon(Icons.account_circle), 
                        title: Text('Profil'), 
                    ),
                    Divider(),
                    ListTile(
                        leading: Icon(Icons.verified_user), 
                        title: Text('Logout'), 
                    ),
                ],
            ),
        );
    }
}