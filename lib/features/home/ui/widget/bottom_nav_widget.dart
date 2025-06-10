import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/features/home/bloc/home_cubit/home_cubit.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        return CurvedNavigationBar(
          index: context.read<HomeCubit>().getIndex,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          maxWidth: 1.0.sw,
          height: 60.h,
          color: AppColorManager.mainColor,
          buttonBackgroundColor: AppColorManager.mainColor,
          items: [
            ImageMultiType(url: Assets.iconsHome, color: Colors.white, height: 25.0.r, width: 25.0.r),
            ImageMultiType(url: Assets.iconsMyCourses, color: Colors.white, height: 25.0.r, width: 25.0.r),
            if (AppProvider.isLogin)
              ImageMultiType(url: Assets.iconsExams, color: Colors.white, height: 25.0.r, width: 25.0.r),
            ImageMultiType(url: Assets.iconsSettings, color: Colors.white, height: 25.0.r, width: 25.0.r),
          ],
          onTap: (index) {
            context.read<HomeCubit>().jumpPage(index);
          },
        );
      },
    );
  }
}
