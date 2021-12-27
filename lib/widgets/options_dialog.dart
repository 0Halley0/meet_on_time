import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:meet_on_time/utils/cloud_firestore.dart';
import 'poll_settings_dialog.dart';

String dateText = "";
Timestamp dateTimeStamp = Timestamp(0, 0);

class OptionsDialog extends StatefulWidget {
  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF6f686d),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            color: const Color(0xFFd8d0c1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'MEET ON TIME',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Text(
                    'What are the options?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6f686d),
                      fontSize: 18,
                      // fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 3,
                    ),
                  ),
                ),
                optionForm(),
                Container(
                  height: 250,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    itemCount: 5, //daha sonra kullanıcının girdiği kadar olacak
                    itemBuilder: (context, index) {
                      // return Text('Kullanıcının girdisi');
                      return Text(dateText);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class optionForm extends StatefulWidget {
  @override
  optionFormState createState() {
    return optionFormState();
  }
}

class optionFormState extends State<optionForm> {
  final _optionFormKey = GlobalKey<optionFormState>();

  TextEditingController eventChoicesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _optionFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DateTimeFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.more_time),
              hintText: 'Select time',
            ),
            onSaved: (value) {},
            onDateSelected: (DateTime value) {
              dateText = value.toString();
              dateTimeStamp = Timestamp.fromDate(value);
              print(dateText);
            },
            validator: (value) {
              if (value == null) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: eventChoicesController,
            decoration: const InputDecoration(
                icon: Icon(Icons.notes_rounded),
                hintText: 'Additional note (optional)'),
            onChanged: (value) {},
            validator: (value) {
              return null;
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    eventOptions(eventChoicesController.text, dateTimeStamp);
                    eventChoicesController.clear();

                    if (_optionFormKey.currentState != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sending Data to Cloud Firestore'),
                        ),
                      );
                    }
                  },
                  child: Text('Add')),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => PollSettingsDialog(),
                  );
                  if (_optionFormKey.currentState != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sending Data to Cloud Firestore'),
                      ),
                    );
                  }
                },
                child: Text('Next'),
              )
            ],
          )
        ],
      ),
    );
  }
}
