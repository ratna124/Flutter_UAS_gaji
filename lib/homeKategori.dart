import 'package:flutter/material.dart';
import 'formKategori.dart';
import 'database/itemKategori.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//pendukung program asinkron
class HomeKategori extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeKategori> {
  final TextEditingController golonganController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();

  void clearInputText() {
    golonganController.text = "";
    gajiController.text = "";
  }

  CollectionReference _kategori =
      FirebaseFirestore.instance.collection('kategori');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue[100], Colors.blueGrey[100]],
              ),
            ),
            child: ListView(children: [
              StreamBuilder<QuerySnapshot>(
                stream: _kategori.orderBy('Gaji', descending: true).snapshots(),
                builder: (buildContext, snapshot) {
                  return Column(
                    children: snapshot.data.docs
                        .map((e) => ItemCard(
                              e.data()['Golongan'],
                              (e.data()['Gaji']),
                              onUpdate: () {
                                _kategori
                                    .doc(e.id)
                                    .update({"Gaji": e.data()['Gaji'] + 1});
                              },
                              onDelete: () {
                                _kategori.doc(e.id).delete();
                              },
                            ))
                        .toList(),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return EntryFormKategori();
                            }),
                          );
                        }),
                  ),
                ]),
              ),
            ])));
  }
}
