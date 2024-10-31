// import 'package:auto_route/auto_route.dart';
// import 'package:bookimed/common/base/base_page.dart';
// import 'package:bookimed/common/constants/constants.dart';
// import 'package:bookimed/common/router/app_router.dart';
// import 'package:bookimed/common/widgets/custom_button.dart';
// import 'package:bookimed/domain/model/on_boarding_model/on_boarding_model.dart';
// import 'package:bookimed/features/start/onboarding/cubit/on_boarding_cubit.dart';
// import 'package:bookimed/features/start/onboarding/cubit/on_boarding_state.dart';
// import 'package:bookimed/features/start/onboarding/widgets/on_boarding_widgets.dart';
// import 'package:bookimed/gen/assets.gen.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../common/constants/custom_color.dart';
//
//
// @RoutePage()
// class OnBoardingPage extends BasePage<OnBoardingCubit, OnBoardingBuildable,
//     OnBoardingListenable> {
//   const OnBoardingPage({super.key});
//
//   @override
//   Widget builder(BuildContext context, OnBoardingBuildable state) {
//     List<OnBoardingModel> list = [
//       OnBoardingModel(
//         picture: Assets.icons.onboardingPageOne.svg(),
//         text: 'Thousands of doctors & experts to help your health!',
//         buttonName: 'Next',
//         key: 1,
//       ),
//       OnBoardingModel(
//         picture: Assets.icons.onboardingPageTwo.svg(),
//         text: 'Health checks & consultations easily anywhere anytime',
//         buttonName: 'Next',
//         key: 2,
//       ),
//       OnBoardingModel(
//         picture: Assets.icons.onboardingPageThree.svg(),
//         text: "Let's start living healthy and well with us right now!",
//         buttonName: 'Get Started',
//         key: 3,
//       ),
//     ];
//     return Scaffold(
//       floatingActionButton: Container(
//         width: double.maxFinite,
//         margin:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 110.h),
//         child: DotsIndicator(
//           position: state.page,
//           dotsCount: 3,
//           decorator: DotsDecorator(
//             color: ResColors.notActiveColor,
//             activeColor: ResColors.primaryColor,
//             size: const Size.square(8.0),
//             activeSize:  Size(32.w, 8.h),
//             activeShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(100.r),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: Column(
//         children: [
//       OnBoardingPageWidget(list: list, index: state.page),
//           Center(
//             child: Container(
//               width: double.infinity,
//               margin:  EdgeInsets.only(
//                 top: 78.h,
//
//               ),
//               child: CustomButton(
//                 onTap: () {
//                   if (state.page < 2) {
//                     context.read<OnBoardingCubit>().changePage();
//                   } else {
//                     context.read<OnBoardingCubit>().setOnboarded();
//                     context.router.replace(const AuthMainRoute());
//                   }
//                 },
//                 color: ResColors.primaryColor,
//                 text: list[state.page].buttonName,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
