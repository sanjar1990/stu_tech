import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stu_tech/view/pages/student/student_home/controller/student_home_controller.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomeController>(
        init: StudentHomeController(),
        builder: (controller){
          return Scaffold(
            body: Center(
              child: Text('Student'),
            ),
          );
        });
  }
}
