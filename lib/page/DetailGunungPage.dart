import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/models/Gunung.dart';
import 'package:flutter_gunungku_com/page/TabDataGunung.dart';
import 'package:flutter_gunungku_com/page/TabSuntingGunung.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as dev;

class DetailGunungPage extends StatefulWidget {
    int id;
    String title;
    DetailGunungPage({
        this.id,
        this.title
    });

    @override
    _DetailGunungPageState createState() => _DetailGunungPageState();
}

class _DetailGunungPageState extends State<DetailGunungPage> {
    Gunung gunung;
    int _selectedIndexTab = 0;

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title)
            ),
            body: futureBuilderPage(widget.id, _selectedIndexTab),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                    setState(() {
                        this._selectedIndexTab = index;
                    });
                },
                currentIndex: _selectedIndexTab,
                selectedItemColor: Colors.green,
                items: <BottomNavigationBarItem> [
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.mountain),
                        title: Text('Data Gunung')
                    ),
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.pencilAlt),
                        title: Text('Sunting Data')
                    ),
                ],
            ),
        );
    }

    futureBuilderPage(int id, int indexTab) {
        return FutureBuilder(
            future: _getDataGunung(id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                    Gunung gunung = snapshot.data;

                    if (indexTab == 0) {
                        return TabDataGunung(gunung: gunung);
                    }

                    if (indexTab == 1) {
                        return TabSuntingGunung(gunung: gunung);
                    }
                } else if(snapshot.hasError) {
                    return Center(
                        child: Text("Data Tidak Ditemukan"),
                    );
                }

                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                );
            },
        );
    }

    Future<Gunung> _getDataGunung(int id) async {
        final SharedPreferences sp = await SharedPreferences.getInstance();
        try {
            var buffer = StringBuffer();
            buffer.write(sp.getString('apiUrl') + '/index.php?r=api/gunung/view&id=' + id.toString());
            String url = buffer.toString();

            var response = await http.get(url);
            if (response.statusCode == 200) {
                var responseBody = json.decode(response.body);

                if (this.mounted) {
                    setState(() {
                        gunung = Gunung(
                            nama: responseBody['nama'],
                            deskripsi: responseBody['deskripsi'],
                            ketinggian: responseBody['ketinggian'],
                            status_aktif: responseBody['status_aktif'],
                            lokasi: responseBody['lokasi'],
                            jenis_gunung: responseBody['jenis_gunung'],
                            path_gambar: responseBody['path_gambar'],
                            status: responseBody['status']
                        );
                    });
                }
                
                return gunung;
            } else {
                throw Exception("Tidak Ada Response");
            }
        } catch (e) {
            print (e); 
            throw e;
        }
    }
}