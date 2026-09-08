import 'package:college_data_local_storage/models/college_model.dart';
import 'package:college_data_local_storage/services/sqflite_db_service.dart';
import 'package:college_data_local_storage/utils/custom_alert_box.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CollegeEditScreen extends StatefulWidget {
  CollegeEditScreenState createState() => CollegeEditScreenState();
}

class CollegeEditScreenState extends State<CollegeEditScreen> {
  int? id;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController starController = TextEditingController();

  void handleSubmit() async {
    CollegeModel college = CollegeModel(
      id: id,
      name: nameController.text,
      description: descriptionController.text,
      location: locationController.text,
      star: int.parse(starController.text),
    );
    final count = await DbService.instance.updateCollege(college);
    if (count > 0) {
      CustomAlertBox.showSuccess(
        context,
        "Success",
        "College updated Successfully!!!",
      );
      Timer(Duration(seconds: 2), () => Navigator.pop(context));
    } else {
      CustomAlertBox.showError(context, "Error", "Something Went Wrong!!!");
    }
  }

  Widget build(BuildContext context) {
    CollegeModel college =
        ModalRoute.of(context)!.settings.arguments as CollegeModel;
    nameController.text = college.name;
    descriptionController.text = college.description;
    locationController.text = college.location;
    starController.text = college.star.toString();
    id = college.id;

    return Scaffold(
      appBar: AppBar(title: Text("College Edit Screen")),
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
          TextButton(onPressed: handleSubmit, child: Text("Update College")),
        ],
      ),
    );
  }
}
