import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryFormKategori extends StatefulWidget {
  @override
  EntryFormKategoriState createState() => EntryFormKategoriState();
}

//class controller
class EntryFormKategoriState extends State<EntryFormKategori> {
  @override
  final TextEditingController golonganController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();
  CollectionReference _kategori =
      FirebaseFirestore.instance.collection('kategori');

  void clearInputText() {
    golonganController.text = "";
    gajiController.text = "";
  }

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
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // Golongan
                TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  controller: golonganController,
                  decoration: InputDecoration(
                      hintText: "Isi Golongan",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
                TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  controller: gajiController,
                  decoration: InputDecoration(
                      hintText: "Isi Gaji",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  keyboardType: TextInputType.number,
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
                          onPressed: () async {
                            // TODO 1 ADD DATA HERE
                            await _kategori.add({
                              "Golongan": golonganController.text,
                              "Gaji": double.tryParse(gajiController.text),
                            });
                            clearInputText();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
