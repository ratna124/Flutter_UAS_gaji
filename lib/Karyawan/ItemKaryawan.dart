import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projek_gaji/database/Karyawan.dart';
import 'EditScreenKaryawan.dart';

class ItemListKaryawan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data.docs[index].data();
              String docID = snapshot.data.docs[index].id;
              String nama = noteInfo['nama'];
              String alamat = noteInfo['alamat'];
              double noHp = noteInfo['noHp'];

              return Card(
                  child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue[100], Colors.blueGrey[100]],
                  ),
                ),
                // decoration: BoxDecoration(
                //   // color: CustomColors.firebaseGrey.withOpacity(0.1),
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditScreenKaryawan(
                        currentNama: nama,
                        currentAlamat: alamat,
                        currentnoHp: noHp,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    "Nama : " + nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Alamat : " + alamat + "\nNo Hp : " + "$noHp",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ));
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
              // valueColor: AlwaysStoppedAnimation<Color>(
              //   CustomColors.firebaseOrange,
              // ),
              ),
        );
      },
    );
  }
}
