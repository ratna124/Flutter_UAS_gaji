import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Kategori.dart';
import 'CustomFormFieldKategori.dart';

class AddKategori extends StatefulWidget {
  final FocusNode golonganFocusNode;
  final FocusNode gajiFocusNode;

  const AddKategori({
    this.golonganFocusNode,
    this.gajiFocusNode,
  });

  @override
  _AddKategoriState createState() => _AddKategoriState();
}

class _AddKategoriState extends State<AddKategori> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _golonganController = TextEditingController();
  final TextEditingController _gajiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  controller: _golonganController,
                  focusNode: widget.golonganFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: 'Golongan',
                  hint: 'Golongan',
                ),
                SizedBox(height: 24.0),
                CustomFormField(
                  // maxLines: 10,
                  isLabelEnabled: false,
                  controller: _gajiController,
                  focusNode: widget.gajiFocusNode,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  label: 'Gaji',
                  hint: 'Gaji',
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
                      widget.golonganFocusNode.unfocus();
                      widget.gajiFocusNode.unfocus();

                      if (_addItemFormKey.currentState.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await DatabaseKategori.addItem(
                            golongan: _golonganController.text,
                            gaji: double.tryParse(_gajiController.text));

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
                          fontSize: 22,
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
