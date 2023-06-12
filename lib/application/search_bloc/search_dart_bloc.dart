// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../../domain/model/data_model.dart';

part 'search_dart_event.dart';
part 'search_dart_state.dart';

class SearchtBloc extends Bloc<SearchEvent, SearchState> {
  SearchtBloc() : super(SearchInitial()) {
    on<SearchQuery>((event, emit) async {
      final studentDb = await Hive.openBox<StudentModel>("student_db");
      final studentList = studentDb.values
          .where((element) => element.name
              .toLowerCase()
              .contains(event.query.toLowerCase().trim()))
          .toList();
      emit(SearchState(studentList: studentList));
    });
  }
}
