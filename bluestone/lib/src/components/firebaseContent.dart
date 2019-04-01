import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A class that holds a static instance of a [FirebaseUser]
class CurrentLoggedInUser {
  static FirebaseUser user;
}

String documentReference;

/// A class that holds data for various static instances of [DocumentReference]s
/// and [DocumentSnapshot]s
///
/// The two set methods for Document and Collection references take a collectionType string
/// in as a perameter to determine whether to work with Cards or Calendars in Firestore.
///
/// setDocumentReference in particular takes an [String] id in as well as the collectionType
/// for the same pathing reasons. (id referring to the id in the collection "All")
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

  static DocumentReference duplicateData;
  static CollectionReference mainData;

  /// Sets the [DocumentReference] to the testing document
  /// in the database
  static void setFbCardDocTest() {
    firestoreDoc = Firestore.instance.document("TestData/TestDocument");
  }

  static void setDocumentReference(String id, String collectionType) {
    duplicateData = Firestore.instance.document("$collectionType/Live/All/$id");
    print("New path set.");
  }

  static void setCollectionReference(String collectionType) {
    if (collectionType == "Cards") {
      mainData = Firestore.instance.collection(
          "$collectionType/Live/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs");
    } else if (collectionType == "Calendars") {
      mainData = Firestore.instance.collection(
          "$collectionType/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalednarIDs");
    } else {
      print("Error: CollectionType Reference was not set properly.");
    }
  }
}

void documentDeletion() {
  switch (documentReference) {
    case "Sticky":
      FirestoreContent.setDocumentReference(
          "${FirestoreContent.stickySnap.documentID}", "Cards");
      FirestoreContent.stickyDoc = Firestore.instance.document(
          "Cards/Live/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs/${FirestoreContent.stickySnap.documentID}");
      FirestoreContent.stickyDoc.delete().whenComplete(() {
        print("Document Deleted.");
      }).catchError((e) => print(e));
      print("Removing Duplicate Document...");
      FirestoreContent.duplicateData.delete().whenComplete(() {
        print("Duplicate Document Deleted.");
      }).catchError((e) => print(e));
      break;
    case "Checkbox":
      FirestoreContent.setDocumentReference(
          "${FirestoreContent.checkboxSnap.documentID}", "Cards");
      FirestoreContent.checkboxDoc = Firestore.instance.document(
          "Cards/Live/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs/${FirestoreContent.checkboxSnap.documentID}");
      FirestoreContent.checkboxDoc.delete().whenComplete(() {
        print("Document Deleted.");
      }).catchError((e) => print(e));
      print("Removing Duplicate Document...");
      FirestoreContent.duplicateData.delete().whenComplete(() {
        print("Duplicate Document Deleted.");
      }).catchError((e) => print(e));
      break;
    case "Bullet":
      FirestoreContent.setDocumentReference(
          "${FirestoreContent.bulletSnap.documentID}", "Cards");
      FirestoreContent.bulletDoc = Firestore.instance.document(
          "Cards/Live/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs/${FirestoreContent.bulletSnap.documentID}");
      FirestoreContent.bulletDoc.delete().whenComplete(() {
        print("Document Deleted.");
      }).catchError((e) => print(e));
      print("Removing Duplicate Document...");
      FirestoreContent.duplicateData.delete().whenComplete(() {
        print("Duplicate Document Deleted.");
      }).catchError((e) => print(e));
      break;
    default:
      print("Document reference $documentReference is not an option.");
      break;
  }
}
