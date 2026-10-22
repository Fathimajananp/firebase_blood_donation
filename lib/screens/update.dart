import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;
  final CollectionReference donor = FirebaseFirestore.instance.collection(
    'donor',
  );

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void updateDonor(docId){
    final data = {
      'name' : donorName.text,
      'phone' : donorPhone.text,
      'group' : selectedGroup
    };
    donor.doc(docId).update(data).then((Value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    selectedGroup = args['group'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Donors", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: donorName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Donor Name"),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: donorPhone,
              keyboardType: TextInputType.numberWithOptions(),
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Phone Number"),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedGroup,
              decoration: InputDecoration(label: Text("Select Blood Group")),
              items: bloodGroups
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              onChanged: (val) {
                selectedGroup = val as String?;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateDonor(docId);
              },
              child: Text("Update", style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
