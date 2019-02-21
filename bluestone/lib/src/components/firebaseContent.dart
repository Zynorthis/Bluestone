import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


/// This class holds an instance of a [FirebaseUser]
class CurrentLoggedInUser {
  static FirebaseUser user;
}

class FirestoreContent {
  static DocumentReference firestoreDoc;
  static DocumentSnapshot documentSnap;

  static void setFbCardDocument(String visablity, String cardType, String id){
    firestoreDoc = Firestore.instance.document("Cards/$visablity/$cardType/$id");
  }

  // sets the firestoreDoc to the testing document 
  static void setFbCardDocTest(){
    firestoreDoc = Firestore.instance.document("TestData/TestDocument");
  }

  void setData() {
  }
}