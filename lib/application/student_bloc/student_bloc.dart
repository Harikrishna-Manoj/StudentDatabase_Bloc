// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/model/data_model.dart';
import '../../infrastructure/services/db_functions.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<GetAllStudentData>((event, emit) {
      final studentData = StudentBox.getStudentData();
      List<StudentModel> studentslist = studentData.values.toList();
      emit(ListAllStudents(students: studentslist));
    });
    on<AddStudentData>((event, emit) {
      final studentBox = StudentBox.getStudentData();
      studentBox.add(event.studentsdata);
      add(GetAllStudentData());
    });
    on<DeleteStudentData>((event, emit) {
      final studentData = StudentBox.getStudentData();
      studentData.deleteAt(event.index);
      add(GetAllStudentData());
    });
    on<EditStudentData>((event, emit) {
      final studentData = StudentBox.getStudentData();
      studentData.putAt(event.index, event.studentModel);
      add(GetAllStudentData());
    });
  }
}
