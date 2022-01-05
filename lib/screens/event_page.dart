// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late List<bool> isSelected = [];

// List<String> eventTimeList = <String>[];
// // offset'in bizimle alakasi yok, bu oradaki adamin kullandigi bir veri tipi yada string tam detayli bakmadim  String yaptım
// // adam ne manyakmis da sayilari string icinde tut ya da ben herseyi yanlis anladim
// getdata() async{
//   await FirebaseFirestore.instance.collection("Events").doc('eventOptions').get().then((value){
// setState(() {
//       // first add the data to the Offset object
//       List.from(value.data['eventChoices','eventTime']).forEach((element){  //burayı çözersek olacak gibi
//           String data = new Offset(element);
//           // offset'in bizimle alakasi yok ama mantik dogru gibi geliyor
//           //then add the data to the List<Offset>, now we have a type Offset
//           eventTimeList.add(element);
//       });
//
//       });
//    });
//   }

  /*  var document = await FirebaseFirestore.instance.collection('Events').doc('eventOptions');
document.get() => then(function(document) {
    print(document("eventTime"));
});

  var getTableData = FirebaseFirestore.instance
      .collection('Events')
      .doc('eventOptions')
      .get()
      .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
              print(doc["eventTimes"]);
          });
      }); */

  Future<void> firestoreEventOptions = FirebaseFirestore.instance
      .collection('Events')
      .doc('eventOptions')
      .get()
      .then((value) {
    List<String> eventTimeList = [];
    eventTimeList = value.data()!['eventTime'];
    print(eventTimeList);
    value = FirebaseFirestore.instance
        .collection("Events")
        .doc('eventOptions')
        .get() as DocumentSnapshot<Map<String, dynamic>>;

    eventTimeList = value.data()!["eventTime"]["0"]; //
  });
  // eventTimeList string mi olmali ? evet string işaretlemişiz
  // value.data()!["eventTime"] List<List<String>> mi gonderiyor o zaman ?  string göndermesi gerek
  final List<Map> _items = [
    {
      'id': 1,
      'EventTime': 'eventTimeList',
      'EventChoices': 'event Choices',
    },
    {
      'id': 2,
      'EventTime': 't2',
      'EventChoices': 'c2',
    },
    {
      'id': 3,
      'EventTime': 't3',
      'EventChoices': 'c3',
    },
    {
      'id': 4,
      'EventTime': 't4',
      'EventChoices': 'c4',
    },
    {
      'id': 5,
      'EventTime': 't5',
      'EventChoices': 'c5',
    }
  ];

  @override
  void initState() {
    super.initState();
    isSelected = List<bool>.generate(_items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: const Color(0xFFEDEBD7),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text('MEET ON TIME'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      SizedBox(width: screenSize.width / 20),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 50,
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: _createDataTable(),
          ),
        ],
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Time')),
      DataColumn(label: Text('Option'))
    ];
  }

  List<DataRow> _createRows() {
    return _items
        .mapIndexed((index, item) => DataRow(
                cells: [
                  DataCell(Text('#' + item['id'].toString())),
                  DataCell(Text(item['EventTime'])),
                  DataCell(Text(item['EventChoices']))
                ],
                selected: isSelected[index],
                onSelectChanged: (bool? selected) {
                  setState(() {
                    isSelected[index] = selected!;
                  });
                }))
        .toList();
  }
}

/* Padding(
                padding: EdgeInsets.only(top: screenSize.height / 50),
                child: DataTable(
                  //6 sütun 4 satır
                  sortColumnIndex: 0,
                  sortAscending: true,
                  showCheckboxColumn: true,
                  showBottomBorder: false,
                  dividerThickness: 1.0,
                  columns: [
                    DataColumn(label: Text('  ')),
                    DataColumn(
                      label: Text('sütun2'), //numeric: true
                    ),
                    DataColumn(label: Text('sütun3')),
                    DataColumn(label: Text('sütun4')),
                    DataColumn(label: Text('sütun5')),
                    DataColumn(label: Text('sütun6')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Text('örnek'),
                      ),
                      DataCell(
                        Text('örnek'), //placeholder: true
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(Text('örnek')),
                      DataCell(Text('örnek'))
                    ]),
                  ],
                )), 
                
                -------------------------------------------------
                
                Future<void> firestoreEventOptions = FirebaseFirestore.instance
      .collection('Events')
      .doc('eventOptions')
      .get()
      .then((value) {
    print(value.data());
  });
                
                
                */
