import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Karyawan.dart';
import 'CustomFieldKaryawan.dart';
import 'package:projek_gaji/database/Kategori.dart';

class AddKaryawan extends StatefulWidget {
  final FocusNode namaFocusNode;
  final FocusNode alamatFocusNode;
  final FocusNode noHpFocusNode;
  final FocusNode kategoriFocusNode;

  const AddKaryawan({
    this.namaFocusNode,
    this.alamatFocusNode,
    this.noHpFocusNode,
    this.kategoriFocusNode,
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
  var selectedCurrency;

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
                  focusNode: widget.namaFocusNode,
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
                  focusNode: widget.namaFocusNode,
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

                        await DatabaseKaryawan.addItemKaryawan(
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
