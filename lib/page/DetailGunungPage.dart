import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/models/Gunung.dart';
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

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return DefaultTabController(
            length: 1,
            child: Scaffold(
                appBar: AppBar(
                    title: Text(widget.title),
                    bottom: TabBar(
                        tabs: [
                            Tab (
                                icon: FaIcon(
                                    FontAwesomeIcons.mountain,
                                    size: 18,
                                ),
                                text: "Informasi"
                            ),
                            // Tab (
                            //     icon: FaIcon(
                            //         FontAwesomeIcons.pencilAlt,
                            //         size: 18,
                            //     ),
                            //     text: "Sunting Data",
                            // ),
                        ]
                    )
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: null,
                    child: FaIcon(
                        FontAwesomeIcons.shareAlt,
                        color: Colors.white,
                    )
                ),
                body: TabBarView(
                    children: <Widget>[
                        tabFutureDetailGunung(widget.id),
                        //tabFutureSunting(widget.id),
                    ],
                ),
            ),
        );
    }

    Widget _imagesHeader(BuildContext context, Gunung gunung) {
        return SizedBox(
            height: 184,
            child: Stack(
                children: [
                    Positioned.fill(
                        child: Ink.image(
                            image: NetworkImage('http://192.168.43.156/gunungku.com/web' + gunung.path_gambar),
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
                    Divider(),
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

    tabFutureDetailGunung(int id) {
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

    tabFutureSunting(int id) {
        return FutureBuilder(
            future: _getDataGunung(id),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                    Gunung gunung = snapshot.data;

                    if (gunung != null) {
                        return formSuntingGunung(gunung);
                    }

                } else if (snapshot.hasError) {
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

    SingingCharacter _statusGunung = SingingCharacter.dibuka;
    final _nameController = TextEditingController();
    String _myActivity;
    String _myActivityResult;

    formSuntingGunung(Gunung gunung) {
        return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                            //controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Masukan inputan anda',
                                labelText: 'Nama Gunung ',
                            ),
                            initialValue: gunung.nama,
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: ListTile(
                                            title: const Text('Dibuka'),
                                            leading: Radio(
                                                value: SingingCharacter.dibuka,
                                                groupValue: _statusGunung,
                                                onChanged: (SingingCharacter value) {
                                                    setState(() {
                                                        _statusGunung = value;
                                                    });
                                                },
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: ListTile(
                                            title: const Text('Ditutup'),
                                            leading: Radio(
                                                value: SingingCharacter.ditutup,
                                                groupValue: _statusGunung,
                                                onChanged: (SingingCharacter value) {
                                                    setState(() {
                                                        _statusGunung = value;
                                                    });
                                                },
                                            ),
                                        ),
                                    )
                                ],
                            ),
                        ),
                        SizedBox(height: 0),
                        TextFormField(
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Masukan inputan anda',
                                labelText: 'Lokasi ',
                            ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Masukan inputan anda',
                                labelText: 'Ketinggian (mdpl)',
                            ),
                        ),
                        SizedBox(height: 30),
                        Container(
                            child: DropDownFormField(
                                titleText: 'Jenis Gunung',
                                hintText: '-- Pilih Jenis Gunung --',
                                value: _myActivity,
                                onSaved: (value) {
                                    setState(() {
                                        _myActivity = value;
                                    });
                                },
                                onChanged: (value) {
                                    setState(() {
                                        _myActivity = value;
                                    });
                                },
                                dataSource: [
                                    {
                                        "display": "Running",
                                        "value": "Running",
                                    },
                                    {
                                        "display": "Climbing",
                                        "value": "Climbing",
                                    },
                                ],
                                textField: 'display',
                                valueField: 'value',
                            ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Detail Gunung',
                                hintText: 'Masukan inputan anda',
                            ),
                            maxLines: 10,
                        ),
                    
                        // RaisedButton(
                        //     onPressed: () {
                        //         print("nama" + _nameController.text);
                        //         _nameController.text = '';
                        //     },
                        //     child: Text('Submit'),
                        // )
                    ],
                ),
            )
        );
    }
}

enum SingingCharacter { 
    dibuka, ditutup
}