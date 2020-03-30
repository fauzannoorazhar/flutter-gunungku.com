import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/models/Gunung.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabSuntingGunung extends StatefulWidget {
    Gunung gunung;
    TabSuntingGunung({
        this.gunung
    });

    _TabSuntingGunung createState() => _TabSuntingGunung();
}

enum SingingCharacter { 
    dibuka, ditutup
}

class _TabSuntingGunung extends State<TabSuntingGunung> {
    SingingCharacter _statusGunung = SingingCharacter.dibuka;
    final _nameController = TextEditingController();
    String _myActivity;
    String _myActivityResult;

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
        return Scaffold(
            floatingActionButton:  FloatingActionButton(
                onPressed: null,
                child: FaIcon(
                    FontAwesomeIcons.save,
                    color: Colors.white,
                )
            ),
            body: SingleChildScrollView(
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
                                initialValue: widget.gunung.nama,
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
            )
        );
    }
}