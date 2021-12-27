import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String creatorUID;
  String eventName;
  String? eventLocation;
  String? eventNotes;
  List eventSettings;
  List participants;
  DateTime eventTime;
  List eventChoices;

  Event(this.creatorUID, this.eventName, this.eventLocation, this.eventNotes,
      this.eventSettings, this.participants, this.eventTime, this.eventChoices);
}
