import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gunungku_com/Config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gunung {
    int id;
    String nama;
    String deskripsi;
    int ketinggian;
    String jenis_gunung;
    String status_aktif;
    String link_map;
    String path_gambar;
    String lokasi;
    int status;

    Gunung({
        this.id,
        this.nama,
        this.deskripsi,
        this.ketinggian,
        this.jenis_gunung,
        this.status_aktif,
        this.link_map,
        this.path_gambar,
        this.lokasi,
        this.status
    });

    factory Gunung.fetchData(Map<String, dynamic> json) {
        return Gunung(
            id: json['id'],
            nama: json['nama'],
            deskripsi: json['deskripsi'],
            ketinggian: json['ketinggian'],
            jenis_gunung: json['jenis_gunung'],
            status_aktif: json['status_aktif'],
            link_map: json['link_map'],
            path_gambar: json['path_gambar'],
            lokasi: json['lokasi'],
            status: json['status']
        );
    }

    bool isStatusDibuka() {
        if (this.status == 10) {
            return true;
        }

        return false;
    }

    Widget getWidgetStatusGunung() {
        Icon icon;
        if (this.isStatusDibuka()) {
            icon = Icon(
                Icons.check,
                color: Colors.green,
                size: 30.0,
            );
        } else if(!this.isStatusDibuka()) {
            icon = Icon(
                Icons.close,
                color: Colors.red,
                size: 30.0,
            );
        }

        return Column(
            children: <Widget>[
                icon,
                SizedBox(
                    height: 5,
                ),
                Text(this.status_aktif)
            ],
        );
        
    }
}