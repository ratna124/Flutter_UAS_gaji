import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Kategori.dart';
import 'EditItemKategori.dart';

class EditScreenKategori extends StatefulWidget {
  final String currentGolongan;
  final double currentGaji;
  final String documentId;

  EditScreenKategori({
    this.currentGolongan,
    this.currentGaji,
    this.documentId,
  });

  @override
  _EditScreenKategoriState createState() => _EditScreenKategoriState();
}

class _EditScreenKategoriState extends State<EditScreenKategori> {
  final FocusNode _golonganFocusNode = FocusNode();

  final FocusNode _gajiFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _golonganFocusNode.unfocus();
        _gajiFocusNode.unfocus();
      },
      child: Scaffold(
        // backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditItemForm(
              documentId: widget.documentId,
              golonganFocusNode: _golonganFocusNode,
              gajiFocusNode: _gajiFocusNode,
              currentGolongan: widget.currentGolongan,
              currentGaji: widget.currentGaji,
            ),
          ),
        ),
      ),
    );
  }
}
