import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_samle/presentation/edit_profile_screen/editprofile.dart';
import '../../domain/model/data_model.dart';

// ignore: must_be_immutable
class StudentProfile extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 160;

  StudentProfile({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  StudentModel passValue;
  final int passId;

  Widget top() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(clipBehavior: Clip.none, children: [
      Container(margin: EdgeInsets.only(bottom: bottom), child: CoverImage()),
      Positioned(
        top: top,
        left: 100,
        child: ProfileImage(),
      ),
    ]);
  }

  Widget content() {
    return SizedBox(
      width: 200,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' ${passValue.name}',
            style: const TextStyle(
                fontSize: 28, fontFamily: 'Ubuntu', color: Colors.white),
          ),
          Text('Age : ${passValue.age}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Number : ${passValue.num}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Domain:${passValue.domain}',
              style: const TextStyle(fontSize: 18, color: Colors.grey))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CoverImage() => Container(
        color: const Color.fromARGB(251, 199, 207, 206),
        width: double.infinity,
        height: coverHeight,
      );

  // ignore: non_constant_identifier_names
  Widget ProfileImage() => CircleAvatar(
        backgroundImage: passValue.image == 'x'
            ? const AssetImage('assets/pp3.jpg') as ImageProvider
            : FileImage(File(passValue.image!)),
        radius: profileHeight / 2,
      );

  Widget floatbtn(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfile(
                passValueProfile: passValue,
                index: passId,
              ),
            ),
          );
        },
        child: const Icon(Icons.edit_outlined));
  }

//builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: floatbtn(context),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('PROFILE'),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          top(),
          content(),
        ]));
  }
}
