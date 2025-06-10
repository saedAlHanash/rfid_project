// import 'package:rfid_project/generated/assets.dart';
// import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:m_cubit/caching_service/caching_service.dart';
//
// import '../../../../../core/app/app_provider.dart';
// import '../../../../../core/util/shared_preferences.dart';
// import '../../../../../core/widgets/app_bar/app_bar_widget.dart';
// import '../../../../../core/widgets/refresh_widget/refresh_widget.dart';
// import '../../../../../router/go_router.dart';
// import '../../../../educational_grade/bloc/educational_grade_cubit/educational_grade_cubit.dart';
// import '../../../../lessons/bloc/lessons_cubit/lessons_cubit.dart';
// import '../../../../subjects/bloc/subjects_cubit/subjects_cubit.dart';
// import '../../../../summaries/bloc/summaries_cubit/summaries_cubit.dart';
// import '../../../../teachers/bloc/teachers_cubit/teachers_cubit.dart';
//
// class CustomCardWithCurve extends StatelessWidget {
//   const CustomCardWithCurve({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBarWidget(
//           color: Colors.white,
//           title: Text(
//             "المراحل",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           leading: InkWell(
//               onTap: () {
//                 context.read<EducationalGradeCubit>().getData(newData: true);
//                 context.pop();
//               },
//               child: Icon(
//                 Icons.arrow_back_ios_sharp,
//                 color: Colors.black,
//               )),
//         ),
//         body:
//             BlocBuilder<EducationalGradeCubit, EducationalGradeInitial>(builder: (context, state) {
//           return RefreshWidget(
//             isLoading: state.loading,
//             onRefresh: () => context.read<EducationalGradeCubit>().getData(newData: true),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 37),
//               child: ListView.separated(
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         state.getSpinnerItems();
//
//                         AppProvider.volatileEdy = state.result[index];
//                         CachingService.setSupperFilter(
//                             '${AppSharedPreference.getUser.id}${AppSharedPreference.getLocal}${AppProvider.eduGrade.id}');
//                         context.read<SubjectsCubit>().getData(newData: true);
//                         context.read<SummariesCubit>().getData(newData: true);
//                         context.read<LessonsCubit>().getData(newData: true);
//                         context.read<TeachersCubit>().getData(newData: true);
//
//                         context.goNamed(
//                           context,
//                           RouteName.splash,
//
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(10),
//                               topLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10),
//                             ),
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 Assets. /*iconsShape2*/ imagesChose,
//                               ),
//
//                               // Asset image for decoration
//                               fit: BoxFit
//                                   .contain, // Ensures the image covers the entire container area
//                             )),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 15,
//                               ),
//                               Container(
//                                 height: 22,
//                                 width: 2,
//                                 color: Color(0xffD9E8FB),
//                               ),
//                               SizedBox(
//                                 width: 15,
//                               ),
//                               Text(
//                                 state.result[index].name,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                     // ClipPath(child: Container(
//                     //   width: 300,
//                     //   height: 60,
//                     //   decoration: BoxDecoration(
//                     //       color: Color(0xFF2C2C7C), // اللون الخلفي
//                     //       borderRadius: BorderRadius.circular(20)
//                     //   ),
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.all(16.0),
//                     //     child: Stack(
//                     //       children: [
//                     //
//                     //         Align(
//                     //           alignment: Alignment.centerRight,
//                     //           child: Column(
//                     //             mainAxisSize: MainAxisSize.min,
//                     //             crossAxisAlignment: CrossAxisAlignment.end,
//                     //             children: [
//                     //
//                     //               Text(
//                     //           state.result[index].name,
//                     //                 style: TextStyle(
//                     //                   color: Colors.white,
//                     //                   fontSize: 14,
//                     //                 ),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         ),
//                     //
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ));
//                   },
//                   separatorBuilder: (context, state) {
//                     return SizedBox(
//                       height: 15,
//                     );
//                   },
//                   itemCount: state.result.length),
//             ),
//           );
//         }));
//   }
// }
//
// class CustomCardClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     final controlPoint1 = Offset(size.width * 0.8, size.height * 0.6);
//     final controlPoint2 = Offset(size.width * 0.8, size.height * 0.8);
//
//     path.lineTo(0, size.height); // Start from the bottom-left corner
//     path.quadraticBezierTo(
//       controlPoint1.dx,
//       controlPoint1.dy,
//       controlPoint2.dx,
//       controlPoint2.dy,
//     );
//     path.lineTo(size.width, 0); // Straight line to the top-right corner
//     path.lineTo(0, 0); // Close the path
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
// // void main() {
// //   runApp(MaterialApp(
// //     home: CustomCardWithCurve(),
// //   ));
// // }
