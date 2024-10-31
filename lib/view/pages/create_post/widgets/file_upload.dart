import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import 'package:stu_tech/view/pages/create_post/controller/create_post_controller.dart';
import 'package:stu_tech/view/pages/detail_page/controller/detail_page_controller.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  Future<void> selectFile()async{
  final result=await FilePicker.platform.pickFiles(allowMultiple: true);
  if(result==null) return;
    final path=result.files;
    for (var e in path) {
      setState(() {
        String fileName=e.name;
        File? file=File(e.path!);
        Get.find<CreatePostController>().selectedFiles[fileName]=file;
      });
    }


  }
  Future<void> uploadFile()async{
    if(Get.find<ApplicationController>().isTeacher){
      await Get.find<CreatePostController>().uploadFile();
    }else{
      await Get.find<CreatePostController>().uploadAnswerFile();
    }

  }
  @override
  Widget build(BuildContext context) {


    return GetBuilder<CreatePostController>(
        init: CreatePostController(),
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ResColors.primaryElement,
              title: Text('Upload file'),
              centerTitle: true,
            ),
            body: controller.uploadFileLoading?Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.green,),
                SizedBox(height: 20,),
                Text('File is uploading...')
              ],
            ))
            :Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(
                  top: 20.h
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: selectFile,
                        child: Container(

                          width: 200.w,
                          height: 50,
                          color: ResColors.primaryElement,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_file, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text('Select file', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      controller.selectedFiles.isNotEmpty?
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15
                        ),
                        width: double.maxFinite,
                        height: 300.h,
                        child: ListView.builder(
                            itemCount: controller.selectedFiles.length,
                            itemBuilder: (ctx, index)=>Center(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 320.w,
                                      child: Text(controller.selectedFiles.keys.elementAt(index),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),),
                                    ),
                                    SizedBox(width: 10,),
                                    IconButton(onPressed: (){
                                      controller.selectedFiles.remove(controller.selectedFiles.keys.elementAt(index));
                                      controller.update();
                                    },
                                        icon: Icon(Icons.delete))
                                  ],
                                ))),
                      )
                          : controller.uploadedFiles.isEmpty?Text('No file selected'):Text('All files are uploaded'),
                    ],
                  ),

                  GestureDetector(
                    onTap: uploadFile,
                    child: Container(

                      width: 200.w,
                      height: 50,
                      color: ResColors.primaryElement,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Upload file', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),)
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          );
        })  ;
  }
}
