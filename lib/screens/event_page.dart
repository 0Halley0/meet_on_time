// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:collection/collection.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late List<bool> isSelected = [];

  final List<Map> _items = [
    {
      'id': 1,
      'Event Time': 't1',
      'Event Choices': 'c1',
    },
    {
      'id': 2,
      'Event Time': 't2',
      'Event Choices': 'c2',
    },
    {
      'id': 3,
      'Event Time': 't3',
      'Event Choices': 'c3',
    },
    {
      'id': 4,
      'Event Time': 't4',
      'Event Choices': 'c4',
    },
    {
      'id': 5,
      'Event Time': 't5',
      'Event Choices': 'c5',
    }
  ];

  @override
  void initState() {
    super.initState();
    isSelected = List<bool>.generate(_items.length, (index) => false);
  }

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
                  DataCell(Text(item['event time'])),
                  DataCell(Text(item['event choices']))
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
                )), */