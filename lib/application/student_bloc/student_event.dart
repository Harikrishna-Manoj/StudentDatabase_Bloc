part of 'student_bloc.dart';

@immutable
abstract class StudentEvent extends Equatable {
  List<Object> get properties => [];
}

class AddStudentData extends StudentEvent {
  final StudentModel studentsdata;

  AddStudentData({required this.studentsdata});
  @override
  List<Object?> get props => [studentsdata];
}

class GetAllStudentData extends StudentEvent {
  GetAllStudentData();

  @override
  List<Object> get props => [];
}

class DeleteStudentData extends StudentEvent {
  final List<StudentModel> studentModel;
  final int index;

  DeleteStudentData({required this.studentModel, required this.index});
  @override
  List<Object?> get props => [studentModel];
}

class EditStudentData extends StudentEvent {
  final StudentModel studentModel;
  final int index;

  EditStudentData({required this.studentModel, required this.index});
  @override
  List<Object?> get props => [studentModel, index];
}
