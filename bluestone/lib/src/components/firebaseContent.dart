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
  static DocumentSnapshot documentSnap;

  /// Sets the [DocumentReference] based on the path provided in the
  /// paremeters 
  static void setFbCardDocument(String personal, String id){
    firestoreDoc = Firestore.instance.document("Cards/$personal/UIDs/$id/CardIDs");
  }

  /// Sets the [DocumentReference] to the testing document
  /// in the database
  static void setFbCardDocTest(){
    firestoreDoc = Firestore.instance.document("TestData/TestDocument");
  }

  void setData() {
  }
}