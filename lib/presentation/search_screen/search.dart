import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:hive_samle/presentation/profile_screen/profile.dart';
import '../../domain/model/data_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);

//function or widgets

  Widget expanded() {
    return Expanded(
      child: studentDisplay.isNotEmpty
          ? ListView.builder(
              itemCount: studentDisplay.length,
              itemBuilder: (context, index) {
                File img = File(studentDisplay[index].image!);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(img),
                    radius: 22,
                  ),
                  title: Text(
                    studentDisplay[index].name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentProfile(
                          passId: index,
                          passValue: studentDisplay[index],
                        ),
                      ),
                    );
                  }),
                );
              },
            )
          : const Center(
              child: Text(
                'No match found',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget searchTextField() {
    return TextFormField(
      autofocus: true,
      controller: _searchController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.black),
          onPressed: () => clearText(),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 158, 158, 158),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: 'search',
      ),
      onChanged: (value) {
        _searchStudent(value);
      },
    );
  }

  void _searchStudent(String value) {
    setState(() {
      studentDisplay =
          studentList.where((element) => element.name.contains(value)).toList();
    });
  }

  void clearText() {
    _searchController.clear();
  }

  //builder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              searchTextField(),
              expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
