import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_samle/application/student_bloc/student_bloc.dart';
import '../../../domain/model/data_model.dart';
import '../../profile_screen/profile.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentInitial) {
          context.read<StudentBloc>().add(GetAllStudentData());
        }
        if (state is ListAllStudents) {
          if (state.students.isNotEmpty) {
            return ListView.separated(
              itemBuilder: ((ctx, index) {
                final data = state.students[index];

                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: data.image == 'x'
                        ? const AssetImage('assets/pp3.jpg') as ImageProvider
                        : FileImage(File(data.image!)),
                  ),
                  title: Text(
                    data.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    data.age,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentProfile(
                                  passId: index,
                                  passValue: data,
                                )));
                  }),
                  trailing: IconButton(
                      onPressed: () {
                        deleteAlert(context, index, state.students);
                        //deleteStudent(index);
                      },
                      icon: const Icon(
                        Icons.delete_outlined,
                        color: Colors.red,
                      )),
                );
              }),
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: state.students.length,
            );
          }
        }
        return const Center(
          child: Text(
            "List is Empty",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}

deleteAlert(BuildContext context, int index, List<StudentModel> studentList) {
  showDialog(
    context: context,
    builder: ((ctx) => AlertDialog(
          content: const Text('Are you sure you want to delete'),
          actions: [
            TextButton(
                onPressed: () {
                  context.read<StudentBloc>().add(DeleteStudentData(
                      studentModel: studentList, index: index));
                  Navigator.of(context).pop(ctx);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ctx),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        )),
  );
}
