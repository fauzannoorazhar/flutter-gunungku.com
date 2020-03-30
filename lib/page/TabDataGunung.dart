import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/models/Gunung.dart';

class TabDataGunung extends StatefulWidget  {
    Gunung gunung;
    TabDataGunung({this.gunung});

    _TabDataGunung createState() => _TabDataGunung();
}

class _TabDataGunung extends State<TabDataGunung> {
    @override
    Widget build(BuildContext context) {
    // TODO: implement build
        return Container(
            child: ListView(
                children: <Widget>[
                    _imagesHeader(context, widget.gunung),
                    _listCardIcon(widget.gunung),
                    _contentArticle(context, widget.gunung),
                ],
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
}