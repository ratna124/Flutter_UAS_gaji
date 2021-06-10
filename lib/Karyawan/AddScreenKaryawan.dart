import 'package:flutter/material.dart';
import 'AddKaryawan.dart';


class AddScreenKaryawan extends StatelessWidget {
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _alamatFocusNode = FocusNode();
  final FocusNode _noHpFocusNode = FocusNode();

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
           leading: Icon(Icons.keyboard_arrow_left),
           title: Text("Add Karyawan"),
        //   backgroundColor: CustomColors.firebaseNavy,
        //   title: AppBarTitle(),
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
            child: AddKaryawan(
              namaFocusNode: _namaFocusNode,
              alamatFocusNode: _alamatFocusNode,
              noHpFocusNode: _noHpFocusNode,
            ),
          ),
        ),
      )
    );
  }
}