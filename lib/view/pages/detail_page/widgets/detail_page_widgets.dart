import '../../../../data/tools/file_importer.dart';
import '../../../widgets/custom_widgets.dart';


Widget getText({required String title, required String content}){
  return    Container(
    padding: EdgeInsets.only(
      left: 10
    ),
    width: double.maxFinite,
    color: ResColors.primaryBackground,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:',style: TextStyle(fontSize: 16),),
        Text(content,style: TextStyle(fontSize: 16),),
        SizedBox(height: 15,)
      ],
    ),
  );
}
Widget createAnswerDescription(
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
                  color: ResColors.borderColor),
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
                hintText:'Enter description',
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