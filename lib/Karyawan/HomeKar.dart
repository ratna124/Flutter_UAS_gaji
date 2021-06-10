import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ItemKaryawan.dart';
import 'AddKaryawan.dart';

//pendukung program asinkron
class HomeKar extends StatefulWidget {
  @override
  HomeKarState createState() => HomeKarState();
}

class HomeKarState extends State<HomeKar> {
  @override
  CollectionReference _karyawan =
      FirebaseFirestore.instance.collection('Pegawai');
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.firebaseNavy,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: CustomColors.firebaseNavy,
        // title: AppBarTitle(),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddKaryawan(),
            ),
          );
        },
        // backgroundColor: CustomColors.firebaseOrange,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
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
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: ItemListKaryawan(),
        ),
      )
    );
  }
}