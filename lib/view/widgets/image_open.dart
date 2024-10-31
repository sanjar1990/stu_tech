import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../data/tools/styles/res_colors.dart';

class ImageOpen extends StatelessWidget {
   ImageProvider? imageProvider;
   ImageOpen({super.key,  this.imageProvider } );

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ResColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider??const AssetImage('assets/images/no_photo.jpg'),
                  )
                ),
        
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: ResColors.primarySecondaryElementText,
                  size: 23.sp,
                  shadows: const <Shadow>[
                    Shadow(
                        color: Colors.black54,
                        blurRadius: 1.0)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
