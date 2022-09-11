import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class GetUserDetails {
  final l = Logger();
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  Future getData({allData, loop}) async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    l.w(allData);
    return allData;
  }
}
