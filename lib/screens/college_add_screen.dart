import 'package:college_data_local_storage/models/college_model.dart';
import 'package:college_data_local_storage/services/sqflite_db_service.dart';
import 'package:college_data_local_storage/utils/custom_alert_box.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CollegeAddScreen extends StatefulWidget {
  CollegeAddScreenState createState() => CollegeAddScreenState();
}

class CollegeAddScreenState extends State<CollegeAddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController starController = TextEditingController();

  void handleSubmit() async {
    CollegeModel college = CollegeModel(
      id: null,
      name: nameController.text,
      description: descriptionController.text,
      location: locationController.text,
      star: int.parse(starController.text),
    );
    final count = await DbService.instance.insertCollege(college);
    if (count > 0) {
      CustomAlertBox.showSuccess(
        context,
        "Success",
        "College Created Successfully!!!",
      );
      Timer(Duration(seconds: 2), () => Navigator.pop(context));
    } else {
      CustomAlertBox.showError(context, "Error", "Something Went Wrong!!!");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("College Add Screen")),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          TextField(
            controller: starController,
            decoration: InputDecoration(labelText: 'Star'),
          ),
          TextButton(onPressed: handleSubmit, child: Text("Add College")),
        ],
      ),
    );
  }
}
