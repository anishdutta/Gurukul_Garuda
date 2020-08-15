import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String uid;

  Database({this.uid});

  final CollectionReference profileCollection =
      Firestore.instance.collection('Classes');

  Future updateUserData3(String classes) async {
    return await profileCollection.document(uid).setData({
      'Classes': classes,
    });
  }

//profile list from snapshot

//  List<Profile> _profileList(QuerySnapshot snapshot) {
//    return snapshot.documents.map((doc) {
//      return Profile(
//          age: doc.data['age'] ?? '',
//          weight: doc.data['Weight'] ?? '',
//          height: doc.data['Height'] ?? '');
//    }).toList();
//  }
//
//  UserData _userDataSnapshot(DocumentSnapshot snapshot) {
//    return UserData(
//        uid: uid,
//        height: snapshot.data['Height'],
//        weight: snapshot.data['Weight'],
//        Age: snapshot.data['age']);
//  }
//
//  //get method
//  Stream<List<Profile>> get profile {
//    return profileCollection.snapshots().map(_profileList);
//  }
//
//  Stream<UserData> get userData {
//    return profileCollection.document(uid).snapshots().map(_userDataSnapshot);
//  }
//}
}
