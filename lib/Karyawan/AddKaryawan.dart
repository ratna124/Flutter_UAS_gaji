import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Karyawan.dart';
import 'CustomFieldKaryawan.dart';

class AddKaryawan extends StatefulWidget {
  final FocusNode namaFocusNode;
  final FocusNode alamatFocusNode;
  final FocusNode noHpFocusNode;

  const AddKaryawan({
    this.namaFocusNode,
    this.alamatFocusNode,
    this.noHpFocusNode,
  });

  @override
  _AddKaryawanState createState() => _AddKaryawanState();
}

class _AddKaryawanState extends State<AddKaryawan> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
      key: _addItemFormKey,
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
                SizedBox(height: 25.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _namaController,
                  focusNode: widget.namaFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: 'Nama',
                  hint: 'Nama',
                ),
                SizedBox(height: 24.0),
                CustomFormField(
                  isLabelEnabled: false,
                  maxLines: 3,
                  controller: _alamatController,
                  focusNode: widget.alamatFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: 'Alamat',
                  hint: 'Alamat',
                ),
                SizedBox(height: 24.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _noHpController,
                  focusNode: widget.noHpFocusNode,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  label: 'No. HP',
                  hint: 'No. HP',
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      // widget.namaFocusNode.unfocus();
                      // widget.alamatFocusNode.unfocus();
                      // widget.noHpFocusNode.unfocus();

                      if (_addItemFormKey.currentState.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.addItemKaryawan(
                            nama: _namaController.text,
                            alamat: _alamatController.text,
                            noHp: double.tryParse(_noHpController.text));

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
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
      )
    );
  }
}
