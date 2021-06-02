import 'package:flutter/material.dart';

class EntryFormKategori extends StatefulWidget {
  @override
  EntryFormKategoriState createState() => EntryFormKategoriState();
}

//class controller
class EntryFormKategoriState extends State<EntryFormKategori> {
  TextEditingController golonganController = TextEditingController();
  TextEditingController gajiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //kondisi
    //rubah
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blueGrey[100]],
          ),
        ),
        child : Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // Golongan
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: golonganController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Golongan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // Gaji
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: gajiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Gaji',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                          ),
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        ),
      );
  }
}