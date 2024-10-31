import 'package:google_fonts/google_fonts.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/view/pages/create_post/controller/create_post_controller.dart';
import 'package:stu_tech/view/widgets/custom_widgets.dart';

Widget createTitle(void Function(String) func, CreatePostController controller, BuildContext context){
  return SizedBox(
    // width: 328.w,
    height: 138.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(Strings.enterTitle.tr),
        Container(
          // width: 328.w,
          height: 88.h,
          margin: EdgeInsets.only(top: 10.h),
          decoration: BoxDecoration(
              color: ResColors.white,

              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(width: 1, color:controller.titleIsEmpty?ResColors.emptyError : ResColors.borderColor)
          ),
          child:SizedBox(
            // width: 326.w,

            child:  TextField(
                onChanged: func,
                onTapOutside: (value){
                  FocusScope.of(context).requestFocus( FocusNode());
                },
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration:   InputDecoration(
                  hintText: controller.isUpdate?controller.postTitle:'Enter title' ,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      color: controller.isUpdate?ResColors.primaryText:ResColors.secondaryText
                  )
                ),
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    color: ResColors.primaryText
                )
            ),
          ),
        ),
      ],
    ),
  );
}




Widget createPostDescription(CreatePostController controller,
    BuildContext context, void Function(String) func) {
  return Container(
    height: 190.h,
    margin: EdgeInsets.only(top: 16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(Strings.description.tr,),
        Container(
            // width: 328.w,
            height: 140.h,
            margin: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                  width: 1,
                  color:
                  controller.descriptionIsEmpty
                      ? ResColors.emptyError
                      : ResColors.borderColor),
            ),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              // controller: controller,
              minLines: 6,

              // any number you need (It works as the rows for the textarea)
              keyboardType: TextInputType.multiline,
              maxLines: null,

              onChanged: func,
              onTapOutside: (value){
                FocusScope.of(context).requestFocus( FocusNode());
              },
              decoration:  InputDecoration(
hintText: controller.isUpdate?controller.description:'Enter description',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),

              style: TextStyle(
                  color: ResColors.primaryText,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp),
              autocorrect: false,
            )),
      ],
    ),
  );
}