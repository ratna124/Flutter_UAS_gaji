import 'package:flutter/material.dart';
import 'AddKategori.dart';


class AddScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        // backgroundColor: CustomColors.firebaseNavy,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: CustomColors.firebaseNavy,
        //   title: AppBarTitle(),
        // ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddKategori(
              golonganFocusNode: _titleFocusNode,
              gajiFocusNode: _descriptionFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}