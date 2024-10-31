import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stu_tech/data/storage/auth/auth_holder.dart';
import 'package:stu_tech/view/pages/completed/controller/completed_controller.dart';
import 'package:stu_tech/view/pages/completed_detail/controller/completed_detail_controller.dart';

import '../../widgets/custom_widgets.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedController>(
        init: CompletedController(),
        builder: (controller){
          return StreamBuilder(stream: FirebaseFirestore.instance.collection(Get.find<AuthHolder>().userId).snapshots(),
    builder: (ctx, taskSnapshots){
      if(taskSnapshots.connectionState==ConnectionState.waiting){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if(!taskSnapshots.hasData || taskSnapshots.data!.docs.isEmpty){
        return Center(
          child: Text('No tasks found!'),
        );
      }
      if(taskSnapshots.hasError){
        return Center(
          child: Text(taskSnapshots.error.toString()),
        );
      }
      final loadedTasks=taskSnapshots.data!.docs;
      return Scaffold(
        appBar: customAppBar('My Completed Tasks'),
        body: Container(
          margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16
          ),
          child:
          ListView.builder(
              itemCount:loadedTasks.length,
              itemBuilder: (context, index){
                return Card(
                  elevation: 10,
                  shadowColor: Colors.grey.shade100,
                  child: ListTile(
                    onTap: ()async{
                       await   Get.find<CompletedDetailController>().setTask(loadedTasks[index].data());
                       await   Get.find<CompletedDetailController>().getTask();
                       Get.toNamed('/completed_detail');
                    },
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText('Check status:'),
                        customText(loadedTasks[index].data()['check_status'])
                      ],
                    ),
                    title:Text( loadedTasks[index].data()['task_title']),
                    trailing: Text( loadedTasks[index].data()['created_date']),
                  ),
                );
              }),
        ),
      );
    });
        });
  }
}
