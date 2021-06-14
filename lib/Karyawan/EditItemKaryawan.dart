import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Karyawan.dart';
import 'CustomFieldKaryawan.dart';
import 'package:projek_gaji/database/Kategori.dart';

class EditItemKaryawan extends StatefulWidget {
  final FocusNode namaFocusNode;
  final FocusNode alamatFocusNode;
  final FocusNode noHpFocusNode;
  final FocusNode kategoriFocusNode;
  final String currentNama;
  final String currentAlamat;
  final double currentnoHp;
  final String currentKategori;
  final String documentId;

  const EditItemKaryawan({
    this.namaFocusNode,
    this.alamatFocusNode,
    this.noHpFocusNode,
    this.kategoriFocusNode,
    this.currentNama,
    this.currentAlamat,
    this.currentnoHp,
    this.currentKategori,
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
  TextEditingController _kategoriController  = TextEditingController();
  var selectedCurrency;

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

    _kategoriController = TextEditingController(
      text: widget.currentKategori,
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
                SizedBox(height: 25.0),
                 Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                  controller: _namaController,
                  focusNode: widget.namaFocusNode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                  controller: _alamatController,
                  focusNode: widget.alamatFocusNode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Alamat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                  controller: _noHpController,
                  focusNode: widget.noHpFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'No HP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: DatabaseKategori.readItems(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          const Text("Loading.....");
                        else {
                          List<DropdownMenuItem> currencyItems = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            var snap = snapshot.data.docs[i].data();
                            String nama = snap['golongan'];
                            currencyItems.add(
                              DropdownMenuItem(
                                child: Text(
                                  nama,
                                  style: TextStyle(color: Color(0xFF64B5F6)),
                                ),
                                value: "${nama}",
                              ),
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 50.0),
                              DropdownButton(
                                items: currencyItems,
                                onChanged: (currencyValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Selected Currency value is $currencyValue',
                                      style:
                                          TextStyle(color: Color(0xFF64B5F6)),
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedCurrency = currencyValue;
                                  });
                                },
                                value: selectedCurrency,
                                isExpanded: false,
                                hint: new Text(
                                  "Choose Currency Type",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
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
                      widget.kategoriFocusNode.unfocus();

                      if (_editItemFormKey.currentState.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await DatabaseKaryawan.updateItem(
                          docId: widget.documentId,
                          nama: _namaController.text,
                          alamat: _alamatController.text,
                          noHp: double.tryParse(_noHpController.text),
                            kategori: selectedCurrency,
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