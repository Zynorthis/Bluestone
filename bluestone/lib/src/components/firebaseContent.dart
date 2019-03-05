import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


/// A class that holds a static instance of a [FirebaseUser]
class CurrentLoggedInUser {
  static FirebaseUser user;
}

/// A class that holds a static instance of a [DocumentReference]
/// and a [DocumentSnapshot]
class FirestoreContent {
  static DocumentReference firestoreDoc;
  static DocumentReference stickyDoc;
  static DocumentReference checkboxDoc;
  static DocumentReference bulletDoc;
  static DocumentReference calendarDoc;
  static DocumentReference eventDoc;
  static DocumentSnapshot stickySnap;
  static DocumentSnapshot checkboxSnap;
  static DocumentSnapshot bulletSnap;
  static DocumentSnapshot calendarSnap;
  static DocumentSnapshot eventSnap;

  /// Sets the [DocumentReference] to the testing document
  /// in the database
  static void setFbCardDocTest(){
    firestoreDoc = Firestore.instance.document("TestData/TestDocument");
  }

  void setData() {
  }
}