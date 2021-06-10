import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Karyawan.dart';
import 'EditItemKaryawan.dart';

class EditScreenKaryawan extends StatefulWidget {
  final String currentNama;
  final String currentAlamat;
  final double currentnoHp;
  final String documentId;

  EditScreenKaryawan({
    this.currentNama,
    this.currentAlamat,
    this.currentnoHp,
    this.documentId,
  });

  @override
  _EditScreenKaryawanState createState() => _EditScreenKaryawanState();
}

class _EditScreenKaryawanState extends State<EditScreenKaryawan> {
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _alamatFocusNode = FocusNode();
  final FocusNode _noHpFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _namaFocusNode.unfocus();
        _alamatFocusNode.unfocus();
        _noHpFocusNode.unfocus();
      },
      child: Scaffold(
        // backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          title: Text("Edit Karyawan"),
          // backgroundColor: CustomColors.firebaseNavy,
          // title: AppBarTitle(),
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Database.deleteItem(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blueGrey[100]],
            ),
          ),
            child: EditItemKaryawan(
              documentId: widget.documentId,
              namaFocusNode: _namaFocusNode,
              alamatFocusNode: _alamatFocusNode,
              noHpFocusNode: _noHpFocusNode,
              currentNama: widget.currentNama,
              currentAlamat: widget.currentAlamat,
              currentnoHp: widget.currentnoHp,
            ),
          ),
        ),
      );
  }
}
