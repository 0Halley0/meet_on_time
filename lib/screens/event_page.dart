import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool _isProcessing = false;

  final List _isHovering = [false, false, false];

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: screenSize.height / 25),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: screenSize.width / 50),
            DataTable(
              sortColumnIndex: 0,
              sortAscending: true,
              columns: [
                DataColumn(label: Text('sütun1')),
                DataColumn(label: Text('sütun2'), numeric: true),
              ],
              rows: [
                DataRow(selected: true, cells: [
                  DataCell(Text(''), showEditIcon: true),
                  DataCell(Text(''), placeholder: true)
                ]),
                DataRow(cells: [DataCell(Text('')), DataCell(Text(''))]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* 
DataTable(
                sortColumnIndex: 0,
                sortAscending: true,
                columns: [
                  DataColumn(label: Text('sütun1')),
                  DataColumn(label: Text('sütun2'), numeric: true),
                ],
                rows: [
                  DataRow(selected: true, cells: [
                    DataCell(Text(''), showEditIcon: true),
                    DataCell(Text(''), placeholder: true)
                  ]),
                  DataRow(cells: [DataCell(Text('')), DataCell(Text(''))]),
                ],
              ), */
