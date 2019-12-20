import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CeremonyTemplateState extends State<CeremonyTemplate> {
  String ceremonyKey;

  CeremonyTemplateState(String ceremonyKey){
    this.ceremonyKey = ceremonyKey;
  }

  //Widget titleSection =


  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ceremonyKey),
          actions: <Widget>[
          ],
        ),
        body: ListView(
          children: <Widget>[
           // Image.asset(
            //  '/Users/bankwestmbs/Downloads/giphy.gif',
            //  width: 600,
             // height: 240,
            //),
          ],
        )
    );
  }


}

class CeremonyTemplate extends StatefulWidget {
  String ceremonyKey;

  CeremonyTemplate(String ceremonyKey){
    this.ceremonyKey = ceremonyKey;
  }

  @override
  CeremonyTemplateState createState() => CeremonyTemplateState(ceremonyKey);
}