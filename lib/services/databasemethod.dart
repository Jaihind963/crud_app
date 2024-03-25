import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addEmployeeDetails(
      Map<String, dynamic> employeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
}
