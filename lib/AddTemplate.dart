import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTemplateForm extends StatefulWidget {
  String ceremonyName;

  AddTemplateForm(String ceremonyName) {
    this.ceremonyName = ceremonyName;
  }

  @override
  AddTemplateFormState createState() {
    return AddTemplateFormState(ceremonyName);
  }
}

class AddTemplateFormState extends State<AddTemplateForm> {
  final _formKey = GlobalKey<FormState>();
  String ceremonyName;

  AddTemplateFormState(String ceremonyName) {
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
                        }
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              )
        ])));
  }
}
