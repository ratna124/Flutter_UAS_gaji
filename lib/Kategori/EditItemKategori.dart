import 'package:flutter/material.dart';
import 'package:projek_gaji/database/Kategori.dart';
import 'CustomFormFieldKategori.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode golonganFocusNode;
  final FocusNode gajiFocusNode;
  final String currentGolongan;
  final double currentGaji;
  final String documentId;

  const EditItemForm({
    this.golonganFocusNode,
    this.gajiFocusNode,
    this.currentGolongan,
    this.currentGaji,
    this.documentId,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  TextEditingController _golonganController = TextEditingController();
  TextEditingController _gajiController  = TextEditingController();

  @override
  void initState() {
    _golonganController = TextEditingController(
      text: widget.currentGolongan,
    );

    _gajiController = TextEditingController(
      text: widget.currentGaji.toString(),
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
                  controller: _golonganController,
                  focusNode: widget.golonganFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  // validator: (value) => Validator.validateField(
                  //   value: value,
                  // ),
                  label: 'Golongan',
                  hint: 'Golongan',
                ),
                SizedBox(height: 24.0),
                CustomFormField(
                  maxLines: 10,
                  isLabelEnabled: false,
                  controller: _gajiController,
                  focusNode: widget.gajiFocusNode,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  // validator: (value) => Validator.validateField(
                  //   value: value,
                  // ),
                  label: 'Gaji',
                  hint: 'Gaji',
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
                      widget.golonganFocusNode.unfocus();
                      widget.gajiFocusNode.unfocus();

                      if (_editItemFormKey.currentState.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await DatabaseKategori.updateItem(
                          docId: widget.documentId,
                          golongan: _golonganController.text,
                          gaji: double.parse(_gajiController.text),
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