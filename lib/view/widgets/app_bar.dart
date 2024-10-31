import 'package:stu_tech/data/tools/file_importer.dart';


class AppBarCustom extends StatelessWidget {
  final String title;

  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      centerTitle: true,
      toolbarHeight: 103.h,
      flexibleSpace: Container(
        width: 360.w,
        height: 130.h,
        decoration: BoxDecoration(
            color: ResColors.primaryElement,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r))),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 34.h),
        child: Text(title,
            style: TextStyle(
                color: ResColors.backgroundColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto")),
      ),
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(24.r),
      //       bottomRight: Radius.circular(24.r),
      //     )
      // ),
    );
  }

}
