import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/models/Gunung.dart';
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

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title)
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: null,
                child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 30.0,
                ),
            ),
            body: futureDetailGunung(widget.id),
        );
    }

    Widget _imagesHeader(BuildContext context, Gunung gunung) {
        return SizedBox(
            height: 184,
            child: Stack(
                children: [
                    Positioned.fill(
                        child: Ink.image(
                            image: NetworkImage('http://192.168.43.156/gunungku.com' + gunung.path_gambar),
                            fit: BoxFit.cover,
                            child: Container(),
                        ),
                    ),
                    Positioned(
                        bottom: 5,
                        left: 16,
                        right: 16,
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text(
                                        gunung.nama,
                                        style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                                    ),
                                    Text(
                                        gunung.ketinggian.toString() + 'mpdl',
                                        style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                                    )
                                ],
                            )
                        ),
                    ),
                ]
            ),
        );
    }

    Widget _listCardIcon(Gunung gunung) {
        return Card(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    child: gunung.getWidgetStatusGunung()
                                ),
                                Expanded(
                                    child: Column(
                                        children: <Widget>[
                                            Icon(
                                                Icons.filter_hdr,
                                                color: Colors.green,
                                                size: 30.0,
                                            ),
                                            SizedBox(
                                                height: 5,
                                            ),
                                            Text(gunung.jenis_gunung)
                                        ],
                                    )
                                ),
                                Expanded(
                                    child: Column(
                                        children: <Widget>[
                                            Icon(
                                                Icons.location_on,
                                                color: Colors.green,
                                                size: 30.0,
                                            ),
                                            SizedBox(
                                                height: 5,
                                            ),
                                            Text(gunung.lokasi)
                                        ],
                                    )
                                ),
                            ],
                        ),
                    )
                ],
            )
        );
    }

    Widget _contentArticle(BuildContext context, Gunung gunung) {
        return Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(
                        "Deskripsi",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1 
                        )
                    ),
                    SizedBox(height: 5),
                    Text(
                        gunung.deskripsi,
                        style: TextStyle(
                            color: Colors.black87,
                            height: 1.5
                        ),
                    ),
                ],
            )
        );
    }

    futureDetailGunung(int id) {
        return FutureBuilder(
            future: _getDataGunung(id),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                    Gunung gunung = snapshot.data;

                    if (gunung != null) {
                        return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: ListView(
                                children: <Widget>[
                                    _imagesHeader(context, gunung),
                                    _listCardIcon(gunung),
                                    _contentArticle(context, gunung),
                                ],
                            ),
                        );
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
        dev.log('sp url : ' + sp.getString('url'));

        var buffer = StringBuffer();
        buffer.write(sp.getString('url') + 'api/gunung/view&id=' + id.toString());
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
    }
}