// ignore_for_file: prefer_const_constructors, use_function_type_syntax_for_parameters
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:collection/collection.dart';
import '../globals.dart' as globals;

Map<String, dynamic>? firestoreData = Map<String, dynamic>();

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late List<bool> isSelected = [];
  List<int> voteCount = [0, 0, 0, 0, 0];

  Future<void> firestoreEventOptions = FirebaseFirestore.instance
      .collection('Events')
      .doc('eventOptions')
      .get()
      .then((value) {
    firestoreData = value.data();
    print(firestoreData.toString());
  });

  final List<Map> _items = [
    {
      'id': 0,
      'EventTime': firestoreData!['eventTime'][0].toString(),
      'EventChoices': firestoreData!['eventChoices'][0].toString(),
    },
    {
      'id': 0,
      'EventTime': firestoreData!['eventTime'][1].toString(),
      'EventChoices': firestoreData!['eventChoices'][1].toString(),
    },
    {
      'id': 0,
      'EventTime': firestoreData!['eventTime'][2].toString(),
      'EventChoices': firestoreData!['eventChoices'][2].toString(),
    },
    {
      'id': 0,
      'EventTime': firestoreData!['eventTime'][3].toString(),
      'EventChoices': firestoreData!['eventChoices'][3].toString(),
    },
    {
      'id': 0,
      'EventTime': firestoreData!['eventTime'][4].toString(),
      'EventChoices': firestoreData!['eventChoices'][4].toString(),
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
        body: Stack(
          children: [
            Positioned(
              child: ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: _createDataTable(),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Image.asset(
                'lib/assets/images/undraw_Winners_re_wr1l.png',
                width: screenSize.width / 6,
                height: screenSize.height / 6,
              ),
              top: screenSize.height / 2,
              left: screenSize.width / 2,
              height: screenSize.height / 2,
              width: screenSize.width / 2,
            ),
            Positioned(
              child: Image.asset('lib/assets/images/undraw_Choose_re_7d5a.png'),
              top: screenSize.height / 2,
              height: screenSize.height / 2,
              width: screenSize.width / 2,
            ),
          ],
        ));
  }

//Duration bekle = Duration(seconds: 5);
  DataTable _createDataTable() {
    print("createDataTable cagrildi");
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Votes')),
      DataColumn(label: Text('Time')),
      DataColumn(label: Text('Option'))
    ];
  }

//Text( item['id'].toString())

  List<DataRow> _createRows() {
    return _items
        .mapIndexed((index, item) => DataRow(
                cells: [
                  DataCell(Text(item['id'].toString())),
                  DataCell(Text(item['EventTime'])),
                  DataCell(Text(item['EventChoices']))
                ],
                selected: isSelected[index],
                onSelectChanged: (bool? selected) {
                  setState(() {
                    isSelected[index] = selected!;
                    if (globals.hiddenPollToggle == true) {
                      item['id'] = "hidden";

                      if (isSelected[index] == true) {
                        voteCount[index] += 1;
                      } else {
                        voteCount[index] -= 1;
                      }
                    }

                    if (globals.singleVoteToggle == true) {
                      if (isSelected[index] == true) {
                        for (int i = 0; i < index; i++) {
                          isSelected[i] = false;
                        }
                        for (int i = index + 1; i < 5; i++) {
                          isSelected[i] = false;
                        }
                      }
                    }

                    if (globals.hiddenPollToggle == false &&
                        globals.singleVoteToggle == false) {
                      if (isSelected[index] == true) {
                        item['id'] += 1;
                      } else {
                        item['id'] -= 1;
                      }
                    } else if (globals.hiddenPollToggle == false &&
                        globals.singleVoteToggle == true) {
                      if (isSelected[index] == true) {
                        item['id'] += 1;
                      } else {
                        item['id'] -= 1;
                      }
                    }
                  });
                }))
        .toList();
  }
}

//bool hiddenPollToggle = false; //bool eventSettings
//bool singleVoteToggle = false; //bool eventSettings2
/* 
void pollOptions() {
  if (globals.hiddenPollToggle == true) {
    print('hiddenPollToggle doğru');
    //katılımcılar sonucu oylama sonlanmadan göremez,
    String hiddenVote = 'Hidden';
    
  } else {
    //bütün katılımcılar oy sonuçlarını görür
  }

  if (globals.singleVoteToggle == true) {
    print('singleVoteToggle doğru');
    //katılımcılar sadece tek bir seçeneği işaretleyebilir


  } else {
    //katılımcılar birden fazla seçeneği işaretleyebilir
  }
} 
*/




