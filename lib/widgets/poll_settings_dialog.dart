import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meet_on_time/screens/event_page.dart';
import 'package:meet_on_time/utils/cloud_firestore.dart';
import 'package:meet_on_time/widgets/choose_participants.dart';
import '../globals.dart' as globals;

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
  view() {
    globals.hiddenPollToggle = false; //bool eventSettings
    globals.singleVoteToggle = false; //bool eventSettings2
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _settingsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SwitchListTile(
            title: Text("Hidden poll"),
            subtitle: Text(
                "Participants’ names, comments and votes are confidential. Only you can see the results."),
            isThreeLine: true,
            value: globals.hiddenPollToggle,
            onChanged: (bool value) {
              setState(() => globals.hiddenPollToggle = value);
            },
            activeColor: Colors.green.shade300,
          ),
          SwitchListTile(
            title: Text("Limit participants to a single vote"),
            subtitle: Text("Participants can only select one option."),
            isThreeLine: true,
            value: globals.singleVoteToggle,
            onChanged: (bool value) {
              setState(() => globals.singleVoteToggle = value);
            },
            activeColor: Colors.green.shade300,
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // boolSettings(eventSettings, eventSettings2);
                // uid + saat
                firestore.collection("Events").doc('boolSettings').set({
                  'eventSettings': globals.hiddenPollToggle,
                  'eventSettings2': globals.singleVoteToggle,
                });

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
