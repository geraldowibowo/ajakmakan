import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajak_makan/providers/customer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
import 'dart:io';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('customer');

  final _auth = FirebaseAuth.instance;

  Future<void> updateUserData(
      {String username,
      String name,
      String phoneNumber,
      int points,
      String receiverName,
      String addressLine1,
      String addressLine2 = '',
      double latitude,
      double longitude,
      String addressDescription = ''}) async {
    return await userCollection.doc(_auth.currentUser?.uid).set({
      'username': username,
      'name': name,
      'phoneNumber': phoneNumber,
      'points': points,
      'customerAddress': {
        'receiverName': receiverName,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'geolocation': GeoPoint(latitude, longitude),
        'addressDescription': addressDescription,
      }
    });
  }

  // get brews stream
  // Stream<QuerySnapshot> get customers {
  //   print(userCollection.snapshots());
  //   return userCollection.snapshots();
  // }
  // getCurrentUserData() {
  //   try {
  //     // DocumentSnapshot ds = await userCollection.doc(uid).get();
  //     // // String userName = ds;
  //     print('TRIEEED');
  //     // FutureBuilder<DocumentSnapshot>(
  //     //     future: userCollection.doc(uid).get(),
  //     //     builder: (_, snapshot) {
  //     //       print(snapshot.data);
  //     //       return snapshot.data['name'];
  //     //     });
  //     userCollection.get().then((document) {
  //       return document['name'];
  //     });
  //     // return ds;
  //   } catch (error) {
  //     throw error;
  //   }
  // }
  // Future getSingleData() async {
  //   DocumentSnapshot variable =
  //       await userCollection.doc(uid).get().then((value) {
  //     return value.data();
  //   });
  // }
  // Future<DocumentSnapshot> getCurrentUserData() async {
  //   var ds = await userCollection.doc(uid).get();
  //   print(ds);
  //   return ds;
  // }

  Stream<Customer> get customerData {
    return userCollection
        .doc(_auth.currentUser.uid)
        .snapshots()
        .map((snapshot) {
      return Customer(
        username: snapshot['username'],
        customerId: _auth.currentUser.uid,
        name: snapshot['name'],
        phoneNumber: _auth.currentUser.phoneNumber,
        points: snapshot['points'],
        receiverName: snapshot['customerAddress']['receiverName'],
        addressLine1: snapshot['customerAddress']['addressLine1'],
        addressLine2: snapshot['customerAddress']['addressLine2'],
        addressDescription: snapshot['customerAddress']['addressDescription'],
        latitude: snapshot['customerAddress']['geolocation'].latitude,
        longitude: snapshot['customerAddress']['geolocation'].longitude,
      );
    });
  }

  Future<void> addFeedback({String feedback}) async {
    return await FirebaseFirestore.instance
        .collection('feedback')
        .doc(uid)
        .set({
      'uid': uid,
      'feedback': feedback,
    });
  }

  static Future<String> uploadImage(
      {XFile imageFile, String destination}) async {
    // String fileName = basename(imageFile.path);

    Reference ref = FirebaseStorage.instance.ref('$destination/image');
    File file = File(imageFile.path);
    UploadTask task = ref.putFile(file);
    TaskSnapshot snapshot = await task;

    return await snapshot.ref.getDownloadURL();
  }

  static Future<String> downloadImage({String destination}) async {
    var ref =
        FirebaseStorage.instance.ref('$destination/image').getDownloadURL();

    return await ref;
  }
}
