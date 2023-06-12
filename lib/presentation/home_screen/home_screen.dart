// import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:hive_samle/presentation/home_screen/widget/list_student.dart';
import 'package:hive_samle/presentation/search_screen/search.dart';
import 'package:hive_samle/presentation/addstudent_screen/add_student.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('STUDENT DIRECTORY'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const SearchScreen()),
                  ),
                );
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: StudentList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          add(context);
        },
      ),
    );
  }

  add(BuildContext ctx) {
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (ctx1) => const AddStudentScreen()));
  }
}
