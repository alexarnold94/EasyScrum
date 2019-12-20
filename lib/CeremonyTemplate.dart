import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CeremonyTemplateState extends State<CeremonyTemplate> {
  String ceremonyName;
  var jsonData = [];
  static final String numPeople = "4-12";


  CeremonyTemplateState(String ceremonyName, var jsonData){
    this.ceremonyName = ceremonyName;
    this.jsonData = jsonData;
    //print(jsonData[0]['name']);
  }

  Widget pSection = Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Recommended Number of People:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                numPeople,
                style: TextStyle(color: Colors.grey[500]),
              ),

            ],
          ),
        ),
      ],
    ),
  );


  Widget mSection = Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Required Materials:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "post-it notes\nwhiteboard",
                style: TextStyle(color: Colors.grey[500]),
              ),

            ],
          ),
        ),
      ],
    ),
  );

  Widget methodSection = Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Method:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis maximus fermentum ullamcorper. Aenean purus enim, rutrum ac fringilla at, accumsan eu orci. In et turpis ac odio semper facilisis placerat non massa. Sed vestibulum sagittis erat at scelerisque. Cras et scelerisque dolor, vitae rutrum nunc. Mauris euismod facilisis nulla, id lobortis turpis consectetur nec. Donec tellus nunc, vehicula eu finibus ut, porttitor eu turpis. Vivamus in hendrerit lorem. Aliquam erat volutpat. In sit amet convallis est. Pellentesque id purus at dolor congue elementum quis nec ligula.",
                style: TextStyle(color: Colors.grey[500]),
              ),

            ],
          ),
        ),
      ],
    ),
  );


  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ceremonyName),
          actions: <Widget>[
          ],
        ),
        body: ListView(
          children: <Widget>[
            Image.asset(
              'assets/images/agile_icon.png',
              width: 600,
              height: 240,
            ),
            pSection,
            mSection,
            methodSection,
          ],
        )
    );
  }


}


class CeremonyTemplate extends StatefulWidget {
  String ceremonyName;
  var jsonData;

  CeremonyTemplate(String ceremonyName, var jsonData){
    this.ceremonyName = ceremonyName;
    this.jsonData = jsonData;
  }

  @override
  CeremonyTemplateState createState() => CeremonyTemplateState(ceremonyName, jsonData);
}