import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import 'package:stu_tech/view/pages/create_post/controller/create_post_controller.dart';
import 'package:stu_tech/view/pages/detail_page/controller/detail_page_controller.dart';
import 'package:stu_tech/view/pages/my_tasks/controller/my_tasks_controller.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({super.key});
  void delete(BuildContext context, String id) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
backgroundColor: ResColors.primaryElement,
      content: Column(
        children: [
          Text("Do you want to delete?"),
          Row(children: [
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              FirebaseFirestore.instance.collection('tasks').doc(id).delete();
            }, child: Text('YES', style: TextStyle(
              color: Colors.white
            ),)),
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }, child: Text('Cancel',style: TextStyle(
                color: Colors.white
            ),))
          ],)
        ],
      ),
      duration: const Duration(seconds: 4),

    ));
  }
  void update(Map<String, dynamic> task)async{
    CreatePostController controller=Get.find<CreatePostController>();
    await controller.setIsUpdate(task);
    // Get.find<ApplicationController>().setPageIndex(1);
    Get.toNamed('/create_post');
  }
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<MyTaskController>(
        init: MyTaskController(),
        builder: (controller){
          return StreamBuilder(stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
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
                  appBar: customAppBar('All Tasks'),
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
                                await   Get.find<DetailPageController>().setTask(loadedTasks[index].data());
                                await   Get.find<DetailPageController>().getStudentTaskList();
                                Get.toNamed('/post_detail');
                              },
                              leading: Get.find<ApplicationController>().isTeacher?
                              PopupMenuButton(
                                // constraints: BoxConstraints.expand(width: 110.w, height: 110.h),
                                child: Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Colors.white38,
                                  ),
                                  margin: EdgeInsets.only(top: 4.w, right: 4.w),
                                  child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                          AssetImage('assets/icons/small_edit.png'),
                                        )),
                                  ),
                                ),
                                onSelected: (value) async {
                                  if (value == "update") {
                                    update(loadedTasks[index].data());
                                  } else if (value == "delete") {
                                    print('IDDDDD:::${loadedTasks[index].id}');
                                    delete(context, loadedTasks[index].id);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry>[
                                  PopupMenuItem(
                                    value: "update",
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Icon(Icons.edit, size: 20),
                                        ),
                                        Text(
                                          Strings.updatePost.tr,
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "delete",
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Icon(Icons.delete_outline_outlined,
                                              size: 20),
                                        ),
                                        Text(
                                          Strings.delete.tr,
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                                  :null,

                              title:Text( loadedTasks[index].data()['title']),
                              trailing: Text( loadedTasks[index].data()['created_date']),
                            ),
                          );
                        }),
                  ),
                );
              });
        });

      //   });
  }
}
