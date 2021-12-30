import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/model/participant.dart';

/* 
Kullanici olayin ismini, yerini, notlarini vs. secer
Widgettan alinan bu bilgiler ile Event objesi oluşturulur
Event objesi firestore'a yazılır 
*/

// Olay adi
// Yeri
// Notlar
// Saati
// Seçenekler ?
// Poll settings(hidden poll,
// limit the number of votes per option, single vote)
// emailleri veritabanından çekip

// Kayıt olmadan email'e gelen link ile oy verebilme
// Event objesinde katılımcılar tutulur, katılımcıların emailleri ve

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
String pid = auth.currentUser!.uid.toString();

CollectionReference firestoreParticipants =
    FirebaseFirestore.instance.collection('Participants');

DocumentReference firestoreEvents_newEvent =
    FirebaseFirestore.instance.collection('Events').doc('newEvent');

DocumentReference firestoreEvents_eventOptions =
    FirebaseFirestore.instance.collection('Events').doc('eventOptions');

DocumentReference firestoreEvents_boolSettings =
    FirebaseFirestore.instance.collection('Events').doc('boolSettings');

DocumentReference firestoreEvents_addParticipantToEvent = FirebaseFirestore
    .instance
    .collection('Events')
    .doc('addParticipantToEvent');

// Future<void> addParticipants(
//    String? pid, List<bool>? participantChoices, String? participantEmail) {
// Call the participants' CollectionReference to add a new user
Future<void> newParticipants(Participant participant) {
  return firestoreParticipants
      .add({
        'pid': participant.pid,
        'participantChoices': participant.participantChoices,
        'participantEmail': participant.participantEmail,
      })
      .then((value) => print("Participant Added"))
      .catchError((error) => print("Failed to add participants: $error"));
}

Future<void> newEvent(
    String eventName, String eventLocation, String eventNotes) {
  return firestoreEvents_newEvent
      .set({
        // 'creatorUID': event.creatorUID,
        'eventName': eventName,
        'eventLocation': eventLocation,
        'eventNotes': eventNotes,
        // 'eventSettings': event.eventSettings,
        // 'participants': event.participants,
        // 'eventTime': event.eventTime,
        // 'eventChoices': event.eventChoices,
      })
      .then((value) => print("Event Added"))
      .catchError((error) => print("Failed to add event: $error"));
}

Future<void> eventOptions(String eventChoices, Timestamp eventTime) {
  return firestoreEvents_eventOptions
      .set({
        'eventTime': eventTime,
        'eventChoices': eventChoices,
      })
      .then((value) => print("Event Added"))
      .catchError((error) => print("Failed to add event: $error"));
}

Future<void> boolSettings(bool eventSettings, bool eventSettings2) {
  return firestoreEvents_boolSettings.set({
    'eventSettings': eventSettings,
    'eventSettings2': eventSettings2,
  });
}

Future<void> addParticipantToEvent(List<String> email) {
  return firestoreEvents_addParticipantToEvent.set({
    'participants': email,
  });
}
