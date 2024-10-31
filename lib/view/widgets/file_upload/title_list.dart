import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:stu_tech/view/pages/application/controller/application_controller.dart';
import 'package:stu_tech/view/pages/detail_page/controller/detail_page_controller.dart';
import '../../../data/tools/file_importer.dart';
import '../../pages/create_post/controller/create_post_controller.dart';
import 'directory_path.dart';
import 'package:path/path.dart' as Path;

class TitleList extends StatefulWidget {
  const TitleList({super.key, required this.title, required this.fileUrl, required this.index, required this.isTask});
  final String title;
  final String fileUrl;
  final int index;
  final bool isTask;
  @override
  State<TitleList> createState() => _TitleListState();
}

class _TitleListState extends State<TitleList> {
  bool downloading=false;
  bool fileExists=false;
  double progress=0;
  late String filePath;
  String fileName='';
  var getPathFile=DirectoryPath();
  late CancelToken cancelToken;

  checkFileExists()async{
    var storePath=await getPathFile.getPath();
    filePath='$storePath/$fileName';
    bool fileExistsCheck=await File(filePath).exists();
    setState(() {
      fileExists=fileExistsCheck;
    });
  }
  startDownload()async{
    cancelToken=CancelToken();
    var storePath=await getPathFile.getPath();
    filePath='$storePath/$fileName';
    setState(() {
      downloading = true;
      progress = 0;
    });
    try{
      await Dio().download(widget.fileUrl, filePath,
        onReceiveProgress: (count, total){
          setState(() {
            progress=(count/total);

          },);
        },cancelToken: cancelToken,
      );

      setState(() {
        downloading=false;
        fileExists=true;
      });

    }catch(e){
      setState(() {
        downloading=false;
      });
    }
  }
  void deleteTask() {
    CreatePostController controller=Get.find<CreatePostController>();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ResColors.primaryElement,
      content: Column(
        children: [
          Text("Do you want to delete?"),
          Row(children: [
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              controller.uploadedFiles.remove(controller.uploadedFiles.keys.elementAt(widget.index));
              controller.update();
            }, child: Text('YES', style: TextStyle(
                color: Colors.white
            ),)),
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }, child: Text('Cancel', style: TextStyle(
                color: Colors.white
            ),))
          ],)
        ],
      ),
      duration: const Duration(seconds: 4),

    ));
  }
  void deleteAnswer() {
    DetailPageController controller=Get.find<DetailPageController>();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ResColors.primaryElement,
      content: Column(
        children: [
          Text("Do you want to delete?"),
          Row(children: [
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              controller.uploadedFiles.remove(controller.uploadedFiles.keys.elementAt(widget.index));
              controller.update();
            }, child: Text('YES', style: TextStyle(
                color: Colors.white
            ),)),
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }, child: Text('Cancel', style: TextStyle(
                color: Colors.white
            ),))
          ],)
        ],
      ),
      duration: const Duration(seconds: 4),

    ));
  }
  cancelDownload(){
    if(downloading){
      print('CANCELLLLLL');
      cancelToken.cancel();
      setState(() {
        downloading=false;
      });
    }else{
      if(widget.isTask){
        Get.find<ApplicationController>().isTeacher? deleteTask():null;
      }else{
        deleteAnswer();
      }

    }

  }
  openFile(){
    OpenFile.open(filePath);
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      fileName=Path.basename(widget.fileUrl);
    });
    checkFileExists();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostController>(
        init: CreatePostController(),
        builder: (controller){
          return Card(
            elevation: 10,
            shadowColor: Colors.grey.shade100,
            child:ListTile(
              title:Text(widget.title) ,
              leading:IconButton(

                  onPressed: (){
                    fileExists && downloading==false?
                    openFile():cancelDownload();

                  }, icon:   fileExists && downloading==false?Icon(Icons.window, color: Colors.green,)
                  : Icon(Icons.close,color: Colors.green,)),

              trailing: IconButton(onPressed: (){
                fileExists && downloading==false?
                openFile():  startDownload();

              }, icon: fileExists ?Icon(Icons.save,  color: Colors.green,)
                  : downloading ?Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation<Color>(ResColors.blue),
                  ),
                  Text((progress/100).toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 12
                    ),)
                ],
              )
                  :Icon(Icons.download)
              ),
            ),
          );
        });

  }
}