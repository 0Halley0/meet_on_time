import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meet_on_time/data/model/event.dart';
import 'package:meet_on_time/utils/cloud_firestore.dart';
import '../data/model/participant.dart';
import 'options_dialog.dart';
import '../utils/authentication.dart';

class EventDialog extends StatefulWidget {
  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
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
                    'What\'s the occasion?',
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
                eventForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class eventForm extends StatefulWidget {
  @override
  eventFormState createState() {
    return eventFormState();
  }
}

class eventFormState extends State<eventForm> {
  final _eventFormKey = GlobalKey<eventFormState>();

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventNoteController = TextEditingController();

  // String creatorUID;
  // String eventName;
  // String? eventLocation;
  // String? eventNotes;
  // List eventSettings;
  // List participants;
  // DateTime eventTime;
  // List eventChoices;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _eventFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: eventNameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.event_note_outlined),
              hintText: 'Enter event name',
            ),
            onChanged: (value) {
              eventNameController.text;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: eventLocationController,
            decoration: const InputDecoration(
                icon: Icon(Icons.location_on),
                hintText: 'Enter the event location (optional)'),
            onChanged: (value) {
              eventLocationController.text;
            },
            validator: (value) {
              return null;
            },
          ),
          TextFormField(
            controller: eventNoteController,
            decoration: const InputDecoration(
                icon: Icon(Icons.notes_rounded),
                hintText: 'Additioal note (optional)'),
            onChanged: (value) {
              eventNoteController.text;
            },
            validator: (value) {
              return null;
            },
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // event adi ekle
                // addParticipants(p);
                newEvent(eventNameController.text, eventLocationController.text,
                    eventNoteController.text);
                // FirebaseFirestore.instance
                //     .collection('Events')
                //     .add({'eventName': eventNameController.text});
                showDialog(
                  context: context,
                  builder: (context) => OptionsDialog(),
                );
                if (_eventFormKey.currentState != null) {
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
