import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_samle/application/student_bloc/student_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/model/data_model.dart';
import '../home_screen/home_screen.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.passValueProfile, required this.index})
      : super(key: key);

  StudentModel passValueProfile;
  final int index;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _numController = TextEditingController();
  final _domainController = TextEditingController();
  String? imagePath = 'x';

  //build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('EDIT'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(
                  myController: _nameController,
                  hintName: widget.passValueProfile.name),
              szdBox,
              textFieldNum(
                  myController: _ageController,
                  hintName: widget.passValueProfile.age),
              szdBox,
              textFieldNum(
                  myController: _numController,
                  hintName: widget.passValueProfile.num),
              szdBox,
              textFieldName(
                  myController: _domainController,
                  hintName: widget.passValueProfile.domain),
              szdBox,
              elavatedbtn(),
            ]),
          ),
        ));
  }

  alert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text("Name,Age and Number required")));
  }

  Future<void> takePhoto() async {
    // ignore: non_constant_identifier_names
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: imagePath == 'x'
              ? FileImage(File(widget.passValueProfile.image!))
              : FileImage(File(imagePath!)),
        ),
        Positioned(
          bottom: 10,
          right: 25,
          child: InkWell(
              child: const Icon(
                Icons.add_a_photo_rounded,
                size: 30,
                color: Colors.grey,
              ),
              onTap: () {
                takePhoto();
              }),
        ),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        if (_nameController.text.isEmpty ||
            _ageController.text.isEmpty ||
            _numController.text.isEmpty) {
          alert(context);
        } else {
          final student = StudentModel(
              name: _nameController.text,
              age: _ageController.text,
              num: _numController.text,
              image:
                  imagePath == 'x' ? widget.passValueProfile.image : imagePath,
              domain: _domainController.text);
          context
              .read<StudentBloc>()
              .add(EditStudentData(studentModel: student, index: widget.index));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => const HomeScreen()),
              (route) => false);
        }
      },
      icon: const Icon(Icons.update_rounded),
      label: const Text('Update'),
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, required String hintName}) {
    myController.text = hintName;
    return TextFormField(
      autofocus: false,
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

  Widget textFieldNum(
      {required TextEditingController myController, required String hintName}) {
    myController.text = hintName;
    return TextFormField(
      autofocus: false,
      controller: myController,
      keyboardType: TextInputType.number,
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
}
