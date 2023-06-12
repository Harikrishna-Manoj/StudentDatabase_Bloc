// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_samle/application/student_bloc/student_bloc.dart';
import 'package:hive_samle/domain/model/data_model.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _numController = TextEditingController();
  final _domainController = TextEditingController();

  String imagePath = 'x';

  Future<void> takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  Widget elavatedbtn({required Icon myIcon, required Text myLabel}) {
    return ElevatedButton.icon(
      onPressed: () {
        if (_nameController.text.isNotEmpty &&
            _ageController.text.isNotEmpty &&
            _numController.text.isNotEmpty) {
          Navigator.of(context).pop();
        } else {
          alert(context);
        }
      },
      icon: myIcon,
      label: myLabel,
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, hintName}) {
    return TextFormField(
      // textCapitalization: TextCapitalization.characters,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 158, 158, 158),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: hintName,
      ),
    );
  }

  Widget textFieldNum({required TextEditingController myController, hintName}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      // textCapitalization: TextCapitalization.characters,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 158, 158, 158),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: hintName,
      ),
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: imagePath == 'x'
              ? const AssetImage('assets/pp3.jpg') as ImageProvider
              : FileImage(File(imagePath)),
        ),
        Positioned(
            bottom: 10,
            right: 25,
            child: InkWell(
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 30,
                ),
                onTap: () {
                  takePhoto();
                })),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  //buider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('ADD STUDENT'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: [
              dpImage(),
              szdBox,
              textFieldName(myController: _nameController, hintName: "Name"),
              szdBox,
              textFieldNum(myController: _ageController, hintName: "Age"),
              szdBox,
              textFieldNum(myController: _numController, hintName: "Number"),
              szdBox,
              textFieldName(
                  myController: _domainController, hintName: "Domain"),
              szdBox,
              ElevatedButton.icon(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _ageController.text.isNotEmpty &&
                      _numController.text.isNotEmpty) {
                    Navigator.of(context).pop();
                    BlocProvider.of<StudentBloc>(context).add(AddStudentData(
                        studentsdata: StudentModel(
                            name: _nameController.text.trim(),
                            age: _ageController.text.trim(),
                            num: _numController.text.trim(),
                            image: imagePath,
                            domain: _domainController.text.trim())));
                  } else {
                    alert(context);
                  }
                },
                icon: const Icon(Icons.update),
                label: const Text("Data"),
              ),
            ]),
          ),
        ));
  }

  alert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text("Name,Age and Number required"),
      ),
    );
  }
}
