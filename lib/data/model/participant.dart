import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Participant {
  String? pid;
  List<bool>? participantChoices;
  String? participantEmail;

  Participant(this.pid, this.participantChoices, this.participantEmail);
}
