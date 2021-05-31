import 'package:flutter/material.dart';
import 'formKategori.dart';

//pendukung program asinkron
class HomeKategori extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeKategori> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kategori'),
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
              child: Text("Tambah Kategori"),
              onPressed: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EntryFormKategori();
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