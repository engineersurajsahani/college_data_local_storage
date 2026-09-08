import 'package:flutter/material.dart';
import '../models/college_model.dart';
import '../services/sqflite_db_service.dart';

class CollegeListScreen extends StatefulWidget {
  CollegeListScreenState createState() => CollegeListScreenState();
}

class CollegeListScreenState extends State<CollegeListScreen> {
  List<CollegeModel> colleges = [];

  void loadCollegeData() async {
    final data = await DbService.instance.getAllColleges();
    setState(() {
      colleges = data;
    });
  }

  void initState() {
    super.initState();
    loadCollegeData();
  }

  void handleDelete(int? id) async {
    if (id != null) {
      await DbService.instance.deleteCollege(id);
      loadCollegeData();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("College List")),
      body: ListView.builder(
        itemCount: colleges.length,
        itemBuilder: (context, index) {
          CollegeModel college = colleges[index];
          return ListTile(
            title: Text(college.name),
            subtitle: Text(college.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/college-view',
                      arguments: CollegeModel(
                        id: college.id,
                        name: college.name,
                        description: college.description,
                        location: college.location,
                        star: college.star,
                      ),
                    );
                  },
                  icon: Icon(Icons.visibility),
                ),
                IconButton(
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      '/edit-college',
                      arguments: CollegeModel(
                        id: college.id,
                        name: college.name,
                        description: college.description,
                        location: college.location,
                        star: college.star,
                      ),
                    );
                    loadCollegeData();
                  },
                  icon: Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {
                    handleDelete(college.id);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add-college');
          loadCollegeData();
        },
      ),
    );
  }
}
