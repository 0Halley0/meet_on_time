import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_on_time/widgets/choose_participants.dart';

class PollSettingsDialog extends StatefulWidget {
  @override
  _PollSettingsDialogState createState() => _PollSettingsDialogState();
}

class _PollSettingsDialogState extends State<PollSettingsDialog> {
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
                    'Poll Settings?',
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
                pollSettingsForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class pollSettingsForm extends StatefulWidget {
  @override
  pollSettingsFormState createState() {
    return pollSettingsFormState();
  }
}

class pollSettingsFormState extends State<pollSettingsForm> {
  final _settingsFormKey = GlobalKey<pollSettingsFormState>();

  bool val1 = false;
  bool val2 = false;
  bool val3 = false;

  onchangeFunction1(bool newValue1) {
    setState(() {
      val1 = newValue1;
    });
  }

  onchangeFunction2(bool newValue2) {
    setState(() {
      val2 = newValue2;
    });
  }

  onchangeFunction3(bool newValue3) {
    setState(() {
      val3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _settingsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          SafeArea(
              // HATA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! >:(
              child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSwitch('Hidden poll', val1, onchangeFunction1),
                customSwitch('Limit the number of votes per option', val2,
                    onchangeFunction2),
                customSwitch('Limit participants to a single vote', val3,
                    onchangeFunction3),
              ],
            ),
          )),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ChooseParticipantsDialog(),
                );
                if (_settingsFormKey.currentState != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sending Data to Cloud Firestore'),
                    ),
                  );
                }
              },
              child: Text('Next'),
            ),
          )
        ],
      ),
    );
  }
}

Widget customSwitch(String text, bool val, Function onChangeMethod) {
  return Padding(
    padding: EdgeInsets.symmetric(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: const TextStyle(
              color: Color(0xFF6f686d),
              fontSize: 18,
              // fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              // letterSpacing: 3,
            )),
        Spacer(),
        CupertinoSwitch(
            trackColor: Colors.grey.shade300,
            activeColor: Colors.green.shade200,
            value: val,
            onChanged: (newValue) {
              onChangeMethod(newValue);
            })
      ],
    ),
  );
}
