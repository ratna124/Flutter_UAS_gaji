import 'package:flutter/material.dart';
import 'auth/signin.dart';
import 'auth/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'formKaryawan.dart';
import 'database/itemKaryawan.dart';

//pendukung program asinkron
class HomeKaryawan extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeKaryawan> {
  CollectionReference _karyawan =
      FirebaseFirestore.instance.collection('karyawan');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     name + " | " + email,
        //     style: TextStyle(
        //         fontSize: 20,
        //         color: Colors.deepPurple,
        //         fontWeight: FontWeight.bold),
        //   ),
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blueGrey[100]],
            ),
          ),
          
          child: ListView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream:
                        _karyawan.orderBy('Nama', descending: true).snapshots(),
                    builder: (buildContext, snapshot) {
                      return Column(
                        children: snapshot.data.docs
                            .map((e) => ItemKaryawan(
                                  e.data()['Nama'],
                                  e.data()['Alamat'],
                                  (e.data()['noHp']),
                                  onUpdate: () {
                                    _karyawan
                                        .doc(e.id)
                                        .update({"noHp": e.data()['noHp'] + 1});
                                  },
                                  onDelete: () {
                                    _karyawan.doc(e.id).delete();
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
                     )
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return EntryFormKaryawan();
                            },
                          ),
                        );
                      }),
                ),
                Container(
                  width: 9.0,
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      signOutGoogle();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }), ModalRoute.withName('/'));
                    },
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                       Icons.outbond,
                       color: Colors.white,
                     )
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                )
              ]),
            ),
          ]),
        ));
  }
}
