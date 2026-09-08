import 'screens/college_add_screen.dart';
import 'screens/college_detail_screen.dart';
import 'screens/college_edit_screen.dart';
import 'package:flutter/material.dart';
import 'screens/college_list_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() {
  // Windows / Desktop ke liye initialization
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Data Local Storage',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => CollegeListScreen(),
        '/college-view': (context) => CollegeDetailScreen(),
        '/add-college': (context) => CollegeAddScreen(),
        '/edit-college': (context) => CollegeEditScreen(),
      },
    );
  }
}
