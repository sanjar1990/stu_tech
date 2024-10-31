import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/tools/styles/res_colors.dart';

// Widget buildPage( ApplicationController controller){
//   int index=controller.pageIndex;
//   bool isLoggedIn=controller.loggedIn;
//   bool isAdmin=controller.isAdmin;
//   List<Widget> widgets=[];
//   if(!isLoggedIn){
//     widgets=[
//       const HomePage(),
//       const CategoriesPage(),
//       const RegisterPage(),
//       const RegisterPage(),
//     ];
//   }
//   if(isLoggedIn && isAdmin){
//     widgets=[
//       const HomePage(),
//       const CategoriesPage(),
//       const CreatePostPage(),
//       const FavoritePage(),
//       const ProfilePage()
//     ];
//   }
//   if(isLoggedIn && !isAdmin){
//     widgets= [
//       const HomePage(),
//       const CategoriesPage(),
//       const FavoritePage(),
//       const ProfilePage(),
//     ] ;
//   }
//
//   return widgets[index];
// }
BottomNavigationBarItem item(String label, String icon){
  return  BottomNavigationBarItem(
    icon: SizedBox(
      height: 24.h,
      width: 24.w,
      child: Image.asset('assets/icons/bottom_nav_icon/$icon.png', color: ResColors.bottomNavUnselectColor,),
    ),
    label: label,
    activeIcon: SizedBox(
      height: 24.h,
      width: 24.w,
      child: Image.asset('assets/icons/bottom_nav_icon/$icon.png', color: ResColors.primaryElement,),
    ),
  );
}