import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/util/my_style.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/features/asset/ui/widgets/add_asset_info.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/assets_cubit/assets_cubit.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetsCubit, AssetsInitial>(
          listenWhen: (p, c) => c.done && c.cubitCrud == CubitCrud.create,
          listener: (context, state) {
            context.pushNamed(RouteName.assets);
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
                  ...cState.cRequest.labels.map(
                    (e) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0).r,
                        margin: EdgeInsets.symmetric(vertical: 7.0).r,
                        decoration: MyStyle.outlineBorder,
                        child: DrawableText(
                          text: e,
                          matchParent: true,
                          drawableEnd: InkWell(
                            onTap: () {
                              setState(() {
                                cState.cRequest.labels.remove(e);
                              });
                            },
                            child: ImageMultiType(
                              url: Assets.iconsTimes,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ImageMultiType(
                    url: Assets.iconsHotspot,
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0).r,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: BlocBuilder<AssetsCubit, AssetsInitial>(
                  builder: (context, state) {
                    return MyButton(
                      loading: state.loading,
                      elevation: 0.0,
                      onTap: () {
                        context.read<AssetsCubit>().create();
                      },
                      icon: ImageMultiType(url: Assets.iconsFloppyDisk, height: 24.0, color: Colors.white),
                      text: 'save',
                    );
                  },
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                flex: 7,
                child: MyButton(
                  elevation: 0.0,
                  onTap: () {},
                  icon: ImageMultiType(url: Assets.iconsTrash, height: 24.0, color: Colors.white),
                  text: 'clear',
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                flex: 4,
                child: MyButton(
                  elevation: 0.0,
                  color: Colors.red,
                  onTap: () {},
                  icon: ImageMultiType(url: Assets.iconsStopCircle, height: 24.0, color: Colors.white),
                  text: 'Start',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
