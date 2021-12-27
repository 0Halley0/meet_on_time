import 'package:flutter/material.dart';

class ChooseParticipantsDialog extends StatefulWidget {
  @override
  _ChooseParticipantsDialogState createState() =>
      _ChooseParticipantsDialogState();
}

class _ChooseParticipantsDialogState extends State<ChooseParticipantsDialog> {
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
                    'Choose the participants',
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
                ChooseParticipantsForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseParticipantsForm extends StatefulWidget {
  @override
  ChooseParticipantsFormState createState() {
    return ChooseParticipantsFormState();
  }
}

class ChooseParticipantsFormState extends State<ChooseParticipantsForm> {
  final _chooseparticipantsFormKey = GlobalKey<ChooseParticipantsFormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _chooseparticipantsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.notes_rounded),
                hintText: 'Additioal note (optional)'),
            onChanged: (value) {},
            validator: (value) {
              return null;
            },
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ChooseParticipantsDialog(),
                );
                if (_chooseparticipantsFormKey.currentState != null) {
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
