import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Karyawan.dart';
import 'CustomFieldKaryawan.dart';

class EditItemKaryawan extends StatefulWidget {
  final FocusNode namaFocusNode;
  final FocusNode alamatFocusNode;
  final FocusNode noHpFocusNode;
  final String currentNama;
  final String currentAlamat;
  final double currentnoHp;
  final String documentId;

  const EditItemKaryawan({
    this.namaFocusNode,
    this.alamatFocusNode,
    this.noHpFocusNode,
    this.currentNama,
    this.currentAlamat,
    this.currentnoHp,
    this.documentId,
  });

  @override
  _EditItemKaryawanState createState() => _EditItemKaryawanState();
}

class _EditItemKaryawanState extends State<EditItemKaryawan> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController  = TextEditingController();
  TextEditingController _noHpController  = TextEditingController();

  @override
  void initState() {
    _namaController = TextEditingController(
      text: widget.currentNama,
    );

    _alamatController = TextEditingController(
      text: widget.currentAlamat,
    );

    _noHpController = TextEditingController(
      text: widget.currentnoHp.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _namaController,
                  focusNode: widget.namaFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  // validator: (value) => Validator.validateField(
                  //   value: value,
                  // ),
                  label: 'Nama',
                  hint: 'Nama',
                ),
                SizedBox(height: 24.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _alamatController,
                  focusNode: widget.alamatFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  // validator: (value) => Validator.validateField(
                  //   value: value,
                  // ),
                  label: 'Alamat',
                  hint: 'Alamat',
                ),
                SizedBox(height: 24.0),
                CustomFormField(
                  maxLines: 10,
                  isLabelEnabled: false,
                  controller: _noHpController,
                  focusNode: widget.noHpFocusNode,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  // validator: (value) => Validator.validateField(
                  //   value: value,
                  // ),
                  label: 'No. HP',
                  hint: 'No. HP',
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    // valueColor: AlwaysStoppedAnimation<Color>(
                    //   CustomColors.firebaseOrange,
                    // ),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(
                      //   CustomColors.firebaseOrange,
                      // ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.namaFocusNode.unfocus();
                      widget.alamatFocusNode.unfocus();
                      widget.noHpFocusNode.unfocus();

                      if (_editItemFormKey.currentState.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.updateItem(
                          docId: widget.documentId,
                          nama: _namaController.text,
                          alamat: _alamatController.text,
                          noHp: double.parse(_noHpController.text),
                        );

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          // color: CustomColors.firebaseGrey,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}