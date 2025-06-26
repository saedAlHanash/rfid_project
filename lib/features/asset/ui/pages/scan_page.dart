import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/util/my_style.dart';
import 'package:rfid_project/core/util/snack_bar_message.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/features/asset/ui/widgets/add_asset_info.dart';
import 'package:rfid_project/features/scan/ui/widgets/scan_buttons.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../scan/bloc/scan_cubit/scan_cubit.dart';
import '../../bloc/assets_cubit/assets_cubit.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late final ScanCubit cubit;

  Timer? t;

  @override
  void initState() {
    cubit = context.read<ScanCubit>();
    cubit.init();
    t = Timer.periodic(
      Duration(seconds: 2),
      (timer) => cubit
        ..getStatus()
        ..getData(),
    );

    super.initState();
  }

  @override
  void dispose() {
    cubit.clear();
    cubit.dispose();
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetsCubit, AssetsInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            context.pop();
            NoteMessage.showSuccessSnackBar(message: 'تم بنجاح', context: context);
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorManager.mainColor,
        appBar: AppBarWidget(
          titleText: S.of(context).addProduct,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0).r,
          decoration: BoxDecoration(
            color: AppColorManager.whit,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
          ),
          child: BlocBuilder<AssetsCubit, AssetsInitial>(
            builder: (context, cState) {
              return ListView(
                children: [
                  AddAssetInfo(data: cState.cRequest),
                  20.0.verticalSpace,
                  DrawableText.title(text: 'Tag id'),
                  BlocBuilder<ScanCubit, ScanInitial>(
                    builder: (context, state) {
                      if (state.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return Column(
                        children: [
                          ...state.result.map(
                            (e) {
                              return Container(
                                padding: EdgeInsetsDirectional.only(start: 10.0),
                                margin: EdgeInsets.symmetric(vertical: 7.0).r,
                                decoration: MyStyle.outlineBorder,
                                child: DrawableText(
                                  text: e,
                                  matchParent: true,
                                  drawableEnd: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        cState.cRequest.labels.remove(e);
                                      });
                                    },
                                    icon: ImageMultiType(
                                      url: Assets.iconsTimes,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  ImageMultiType(
                    url: Assets.iconsHotspot,
                    height: 150.0.r,
                    width: 150.0.r,
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: ScanButtons(
          save: BlocBuilder<AssetsCubit, AssetsInitial>(
            builder: (context, state) {
              return MyButton(
                loading: state.loading,
                elevation: 0.0,
                onTap: () {
                  context.read<AssetsCubit>()
                    ..state.cRequest.labels.clear()
                    ..state.cRequest.labels.addAll(cubit.state.result)
                    ..create();
                },
                icon: ImageMultiType(
                    url: Assets.iconsFloppyDisk, height: 24.0, color: Colors.white),
                text: S.of(context).save,
              );
            },
          ),
        ),
      ),
    );
  }
}
