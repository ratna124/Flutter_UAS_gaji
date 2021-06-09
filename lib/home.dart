import 'package:flutter/material.dart';
import 'homeKaryawan.dart';
import 'homeKategori.dart';
import 'auth/drawer.dart';
import 'Kategori/HomeKat.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Penggajian Karyawan",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Center(
                      child: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
                ),
                Tab(
                  child: Center(
                      child: Icon(
                    Icons.category,
                    color: Colors.white,
                  )),
                ),
              ],
            ),
          ),
          drawer: DrawerWidget(),
          body: TabBarView(
            children: [
              HomeKaryawan(),
              HomeKat(),
            ],
          ),
        ),
      ),
    );
  }
}
