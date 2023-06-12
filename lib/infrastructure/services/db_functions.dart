import 'package:hive_flutter/adapters.dart';
import 'package:hive_samle/domain/model/data_model.dart';

class StudentBox {
  static Box<StudentModel> getStudentData() =>
      Hive.box<StudentModel>('student_db');
}
