import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_samle/application/search_bloc/search_dart_bloc.dart';
import 'package:hive_samle/presentation/profile_screen/profile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SearchtBloc>(context).add(SearchQuery(query: ''));
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              searchTextField(context),
              const SizedBox(
                height: 15,
              ),
              expanded(),
            ],
          ),
        ),
      ),
    );
  }

  Widget expanded() {
    return Expanded(
        child: BlocBuilder<SearchtBloc, SearchState>(builder: (context, state) {
      if (state.studentList.isEmpty) {
        return const Center(
          child: Text("No Data Found"),
        );
      }
      return ListView.builder(
        itemCount: state.studentList.length,
        itemBuilder: (context, index) {
          File img = File(state.studentList[index].image!);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(img),
              radius: 22,
            ),
            title: Text(
              state.studentList[index].name,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentProfile(
                    passId: index,
                    passValue: state.studentList[index],
                  ),
                ),
              );
            }),
          );
        },
      );
    }));
  }

  Widget searchTextField(context) {
    return CupertinoSearchTextField(
      onChanged: (value) {
        BlocProvider.of<SearchtBloc>(context).add(SearchQuery(query: value));
      },
      backgroundColor: Colors.grey.withOpacity(0.3),
      prefixIcon: const Icon(
        CupertinoIcons.search,
        color: Colors.grey,
      ),
      suffixIcon: const Icon(
        CupertinoIcons.xmark_circle_fill,
        color: Colors.grey,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
