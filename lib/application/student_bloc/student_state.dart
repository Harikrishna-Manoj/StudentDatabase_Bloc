part of 'student_bloc.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {
  StudentInitial();
  List<Object> get properties => [];
}

class ListAllStudents extends StudentState {
  final List<StudentModel> students;

  ListAllStudents({required this.students});
  List<Object> get properties => [students];
}

class ViewStudent extends StudentState {
  final StudentModel student;

  ViewStudent({required this.student});
  List<Object> get properties => [student];
}
