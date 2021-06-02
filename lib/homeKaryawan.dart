import 'package:flutter/material.dart';
import 'formKaryawan.dart';
import 'auth/signin.dart';
import 'auth/login_page.dart';

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
        title: Text( name + " | " +
                email,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
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
      child : Column(children: [
        Expanded(
          child: Text(
                      "",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
        ),
        Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: RaisedButton(
              color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
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
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
                        )
                  ]),
                ),
      ]),
      ),
    );
  }
}