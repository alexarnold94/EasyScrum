import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTemplateForm extends StatefulWidget {
  String ceremonyName;
  String ceremonyKey;

  AddTemplateForm(String ceremonyName, String ceremonyKey) {
    this.ceremonyName = ceremonyName;
    this.ceremonyKey = ceremonyKey;
  }

  @override
  AddTemplateFormState createState() {
    return AddTemplateFormState(ceremonyName, ceremonyKey);
  }
}

class _FormData {
  String recipeName = '';
  String minParticipants = '';
  String maxParticipants = '';
  String materialsNeeded = '';
  String method = '';
}

class AddTemplateFormState extends State<AddTemplateForm> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  String ceremonyName;
  _FormData _data = new _FormData();

  AddTemplateFormState(String ceremonyName, String ceremonyKey) {
    this.ceremonyName = ceremonyName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Add new " + ceremonyName),
        ),
        body: Form(
          key: _formKey,
          autovalidate: true,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/uploadPlaceholder.jpg")
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                IconButton(icon: Icon(Icons.add_a_photo))
                ]),
              Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Recipe Name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      this._data.recipeName = value;
                    },
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Min participants"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      this._data.minParticipants = value;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Max participants"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      this._data.maxParticipants = value;
                    },
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Materials Needed"),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      this._data.materialsNeeded = value;
                    },
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Method"),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      this._data.method = value;
                    },
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // Process data.
                          _formKey.currentState.save();
                          createRecipe(_data);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Form Submitted!"),
                          ));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              )
        ])));
  }

  void createRecipe(_FormData data) async {
    await databaseReference.collection("recipes").add(
      {
        'ceremony_key': ceremonyName,
        'name': data.recipeName,
        'method': data.method,
        'number_of_participants': data.minParticipants + '-' + data.maxParticipants,
        'required_materials': data.materialsNeeded,
        'image_ref': '',
      }
    );
  }
}
