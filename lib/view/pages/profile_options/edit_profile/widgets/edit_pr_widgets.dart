import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stu_tech/data/tools/file_importer.dart';

class EditPrWidgets extends StatelessWidget {
  const EditPrWidgets({super.key, required this.hintText,
    this.onChanged, required this.icon, required this.fieldName, this.isWorkExperience=false});
final String hintText;
final String fieldName;
final IconData icon;
final bool isWorkExperience;
final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller){
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text(fieldName, style: TextStyle(
                    fontSize: 16
                  ),),
                ),
                SizedBox(height: 8,),
                Container(
                  color: Colors.white,
                  child: TextField(
                    style: const TextStyle(color: ResColors.textColor),
                    onChanged: onChanged,
                    decoration: InputDecoration(
                        prefixIcon: Icon(icon),
                        suffix: isWorkExperience?Text('Years'):null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                            color: ResColors.primaryGrey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                              color:ResColors.primaryGrey
                          ),
                        ),
                        hintText: hintText,
                        hintStyle:
                        const TextStyle(color: Color(0xffABAFB6)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        )),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        });
  }
}




