import 'package:college_data_local_storage/models/college_model.dart';
import 'package:flutter/material.dart';

class CollegeDetailScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    CollegeModel college =
        ModalRoute.of(context)!.settings.arguments as CollegeModel;
    return Scaffold(
      appBar: AppBar(title: Text("College Detail View")),
      body: Center(
        child: Column(
          children: [
            Text("Id :- ${college.id}"),
            Text("Name :- ${college.name}"),
            Text("Description :- ${college.description}"),
            Text("Location :- ${college.location}"),
            Text("Star :- ${college.star}"),
          ],
        ),
      ),
    );
  }
}
