// import 'package:rfid_project/features/educational_grade/bloc/educational_grade_cubit/educational_grade_cubit.dart';
// import 'package:rfid_project/features/educational_grade/bloc/eductaionl_section_cupit/educational_section_cubit.dart';
// import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// import '../../../../../core/widgets/app_bar/app_bar_widget.dart';
// import '../../../../../router/go_router.dart';
// import '../../../../educational_grade/data/response/grad.dart';
//
// class ChooseSec extends StatelessWidget {
//   const ChooseSec({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBarWidget(
//           color: Colors.white,
//           title: Text(
//             "الاقسام",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           leading: InkWell(
//               onTap: () {
//                 context.pop();
//               },
//               child: Icon(
//                 Icons.arrow_back_ios_sharp,
//                 color: Colors.black,
//               )),
//         ),
//         body: BlocBuilder<SectionsCubit, SectionsInitial>(
//             builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//             child: ListView.separated(
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                       onTap: () async {
//                         if (context.read<EducationalGradeCubit>().state.loading) {
//                           showDialog(
//                             context: context,
//                             builder: (context) => CircularProgressIndicator(),
//                           );
//                         } else {
//                           await context
//                               .read<EducationalGradeCubit>()
//                               .getData(request: GradeId(section_id: state.result[index].id));
//                           context.pushNamed( RouteName.custom);
//                         }
//                       },
//                       child: Container(
//                         height: 170,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12), // Rounded corners
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         // Ensures content respects the border radius
//                         child: ImageMultiType(
//                           url: state.result[index].image,
//                           height: 170,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//
//                       /*Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(10),
//                               topLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10),
//                             ),
//                             image: DecorationImage(
//
//                               image: AssetImage(Assets.imagesSh,
//
//                               ),
//
//                               // Asset image for decoration
//                               fit: BoxFit.contain, // Ensures the image covers the entire container area
//                             )),
//                         child:
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 25),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                  // Image.asset(Assets.iconsShild),
//                                   ImageMultiType(
//                                     url: state.result[index].image,
//                                     width: 50,
//                                     height: 50,
//
//                                   ),
//                                   Text(
//                                     state.result[index].name,
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                              SizedBox(width: 50,),
//                             ImageMultiType(
//                               url: Assets.imagesBs,
//                                 width: 150,
//                                  height: 150,
//
//                             ),
//                             // Image.asset(
//                             //   Assets.imagesBs,
//                             //   fit:BoxFit.cover,
//                             //   width: 100,
//                             //   height: 110,
//                             // ),
//                           ],
//                         ),
//                       ),*/
//                       );
//                   // ClipPath(child: Container(
//                   //   width: 300,
//                   //   height: 60,
//                   //   decoration: BoxDecoration(
//                   //       color: Color(0xFF2C2C7C), // اللون الخلفي
//                   //       borderRadius: BorderRadius.circular(20)
//                   //   ),
//                   //   child: Padding(
//                   //     padding: const EdgeInsets.all(16.0),
//                   //     child: Stack(
//                   //       children: [
//                   //
//                   //         Align(
//                   //           alignment: Alignment.centerRight,
//                   //           child: Column(
//                   //             mainAxisSize: MainAxisSize.min,
//                   //             crossAxisAlignment: CrossAxisAlignment.end,
//                   //             children: [
//                   //
//                   //               Text(
//                   //           state.result[index].name,
//                   //                 style: TextStyle(
//                   //                   color: Colors.white,
//                   //                   fontSize: 14,
//                   //                 ),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ));
//                 },
//                 separatorBuilder: (context, state) {
//                   return SizedBox(
//                     height: 10,
//                   );
//                 },
//                 itemCount: state.result.length),
//           );
//         }));
//   }
// }
