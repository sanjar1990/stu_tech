import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../data/tools/file_importer.dart';
import '../../../../widgets/custom_widgets.dart';

class ImageInput extends StatefulWidget {
  final String imageUrl;
  const ImageInput({super.key, required this.imageUrl});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    setState(() {
      Get.find<ProfileController>().isLoading=true;
      _selectedImage = File(pickedImage.path);
    });
    await saveToPostController();
    setState(() {
      Get.find<ProfileController>().isLoading=false;
    });
  }

  Future<void> _selectPicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      Get.find<ProfileController>().isLoading=true;
      _selectedImage = File(pickedImage.path);
    });
    await saveToPostController();
    setState(() {
      Get.find<ProfileController>().isLoading=false;
    });

  }

  ImageProvider _getImage() {
    if (_selectedImage != null) {
      return FileImage(_selectedImage!);
    }
    if (widget.imageUrl.isNotEmpty) {
      return NetworkImage(widget.imageUrl);
    }
    return const AssetImage("assets/images/default_p_p.png");
  }

  Future<void> saveToPostController() async {
    if (_selectedImage != null) {
      File? file = await _cropImage(_selectedImage!);
      if(file==null) return;
      try{
       final storageRef= FirebaseStorage.instance.ref().child('user_image').child(Get.find<AuthHolder>().userId);
     storageRef.putFile(file);
     String imageUrl=await storageRef.getDownloadURL();
       print('IMAGEURLL:::::$imageUrl');
        Get.find<AuthHolder>().photoUrl=imageUrl;
       final userData=await FirebaseFirestore.instance.collection('users').doc(Get.find<AuthHolder>().userId)
           .get();
       FirebaseFirestore.instance.collection('users').doc(Get.find<AuthHolder>().userId)
           .update({
         'username':userData.data()!['username'],
         'email':userData.data()!['email'],
         'role':userData.data()!['role'],
         'image_url':imageUrl
       });
      }on FirebaseException catch(e){
        Get.snackbar(Strings.appName.tr, 'ERROR:$e');
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            cropStyle: CropStyle.rectangle,
            toolbarTitle: Strings.cropper.tr,
            toolbarColor:ResColors.primaryElement,
            activeControlsWidgetColor:ResColors.primaryElement,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            cropStyle: CropStyle.rectangle,
            rectHeight: 600.h,
            rectWidth: 600.w,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.square,
            ],
          ),
        ],
        maxHeight: 600,
        maxWidth: 600);
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  Widget profileButtonAndEditButton() {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: SizedBox(
        height: 120.h,
        width: 120.w,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image(
                  image: _getImage(),
                  height: 120.h,
                  width: 120.w,
                  fit: BoxFit.fitWidth),
            ),
            Center(
              child: GestureDetector(
                onTap: () => showModalImage(),
                child: Image.asset("assets/icons/white_camera_icon.png",
                    height: 30.h, width: 30.w, color: ResColors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showModalImage() {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: customText(Strings.updatePhoto.tr, fontSize: 24.sp,
                fontWeight: FontWeight.w500, textColor: ResColors.primaryText),
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    _takePicture();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: ResColors.primaryElement,
                    ),

                    child: Center(
                      child: customText(Strings.camera.tr, textColor: ResColors.white,  fontSize: 16.sp),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _selectPicture();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: ResColors.primaryElement,
                    ),
                    child: Center(
                      child: customText(Strings.gallery.tr, textColor: ResColors.white,  fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: customText(Strings.exit.tr, textColor: ResColors.stepBlue),
                ),
              )
            ],
            backgroundColor: Colors.white,
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return profileButtonAndEditButton();
  }
}
