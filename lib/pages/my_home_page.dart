import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/pages/employee_page.dart';
import 'package:crud_app/services/databasemethod.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream? employeeStream;
  getontheload() async {
    employeeStream = await DatabaseMethod().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeDetails() {
    return StreamBuilder(
      stream: employeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        margin: const EdgeInsets.only(
                            left: 20, right: 10, bottom: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name:${ds["Name"]}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Age:${ds["Age"]}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                            Text(
                              "Location:${ds["Location"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmployeePage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Text(
              "Firebase",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: allEmployeDetails(),
            )
          ],
        ),
      ),
    );
  }
}
