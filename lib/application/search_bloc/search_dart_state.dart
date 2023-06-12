part of 'search_dart_bloc.dart';

class SearchState {
  final List<StudentModel> studentList;
  const SearchState({required this.studentList});
}

class SearchInitial extends SearchState {
  SearchInitial() : super(studentList: []);
}
