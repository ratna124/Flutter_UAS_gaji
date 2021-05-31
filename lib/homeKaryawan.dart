import 'package:flutter/material.dart';
import 'formKaryawan.dart';

//pendukung program asinkron
class HomeKaryawan extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeKaryawan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Karyawan'),
      ),
      body: Column(children: [
        Expanded(
          child: Text(
                      "",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Karyawan"),
              onPressed: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EntryForm();
                                        },
                                      ),
                                    );
                                  }
            ),
          ),
        ),
      ]),
    );
  }
}