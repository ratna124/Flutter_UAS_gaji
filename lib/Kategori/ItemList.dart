import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projek_gaji/database/Kategori.dart';
import 'EditScreenKat.dart';

class ItemListKategori extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseKategori.readItems(),
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
              String golongan = noteInfo['golongan'];
              double gaji = noteInfo['gaji'];

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

                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditScreenKategori(
                        currentGolongan: golongan,
                        currentGaji: gaji,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    "Golongan : " + golongan,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Gaji : Rp. $gaji",
                    maxLines: 1,
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
