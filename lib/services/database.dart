import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});
  // Collection reference.
  final CollectionReference meetingCollection =
      FirebaseFirestore.instance.collection('meetings');

  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('doctors');

  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patient');

  Future updateDoctorData(String name, String lastName, String color) async {
    return await doctorCollection.doc(uid).set({
      'name': name,
      'lastName': lastName,
      'color': color,
    });
  }
}
