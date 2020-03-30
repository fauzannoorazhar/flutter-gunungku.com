import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/models/Gunung.dart';
import 'package:flutter_gunungku_com/page/DetailGunungPage.dart';
import 'package:flutter_gunungku_com/widgets/MenuDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

class ListGunugPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _ListGunugPageState();
    }
}

class _ListGunugPageState extends State<ListGunugPage> {
    List<Gunung> listGunung = new List<Gunung>();

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return new Scaffold(
            appBar: new AppBar(
                title: Text("Daftar Gunung"),
            ),
            body: _listViewGunung(),
            drawer: MenuDrawer(),
        );
    }

    _listViewGunung() {
        return FutureBuilder(
            future: _getListGunung(),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                    List<Gunung> data = snapshot.data;
                    if (data.length == 0) {
                        return Center(
                            child: Text("Data tidak ditemukan"),  
                        );
                    }

                    return SafeArea(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                                children: <Widget>[
                                    // Container(
                                    //     height: 50,
                                    //     child: Center(
                                    //         child: SectionTitle(
                                    //             title: 'Daftar Gunung' 
                                    //         ),
                                    //     )
                                    // ),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                                return listCardGunung(context, data, index);
                                            },
                                        ),
                                    )
                                ],
                            ),
                        ),
                    );
                } else if (snapshot.hasError) {
                    return Center(
                        child: Text("${snapshot.error}"),  
                    );
                }

                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                );
            },
        );
    }

    Future<List<Gunung>> _getListGunung() async {
        final SharedPreferences sp = await SharedPreferences.getInstance();
        
        var buffer = new StringBuffer();
        buffer.write(sp.getString('apiUrl') + '/index.php?r=api/gunung');
        String url = buffer.toString();
        var response = await http.get(url);

        if (response.statusCode == 200) {
            var responseBody = json.decode(response.body);
            List listJson = responseBody;
            //dev.log('listJson : ' + listJson.toString());

            listGunung = listJson.map((gunung) => new Gunung.fetchData(gunung)).toList();

            return listGunung;
        } else {
            throw Exception("Tidak ada response");
        }
    }

    Widget listCardGunung(BuildContext context, data , index) {
        return SizedBox(
            child: InkWell(
                onTap: () {
                    Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => DetailGunungPage(id: data[index].id, title: data[index].nama))
                    );
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SizedBox(
                                height: 184,
                                child: Stack(
                                    children: [
                                        Positioned.fill(
                                            child: Ink.image(
                                                image: NetworkImage('http://192.168.43.156/gunungku.com/web' + data[index].path_gambar),
                                                fit: BoxFit.cover,
                                                child: Container(),
                                            )
                                        ),
                                        Positioned(
                                            bottom: 16,
                                            left: 16,
                                            right: 16,
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    data[index].nama,
                                                    style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                                                ),
                                            ),
                                        ),
                                    ]
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: DefaultTextStyle(
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.subhead,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            
                                            Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Text(
                                                    'Ketinggian : ' + data[index].ketinggian.toString(),
                                                    style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.black54)
                                                ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Text(
                                                    'Lokasi : ' + data[index].lokasi,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Text(
                                                    'Jenis Gunung : ' + data[index].jenis_gunung,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}

class SectionTitle extends StatelessWidget {
    const SectionTitle({
        Key key,
        this.title,
    }) : super(key: key);

    final String title;
    @override
    Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title, style: Theme.of(context).textTheme.subhead),
            ),
        );
    }
}