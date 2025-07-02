import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/util/my_style.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:rfid_project/features/product/bloc/products_cubit/products_cubit.dart';
import 'package:rfid_project/features/scan/bloc/scan_cubit/scan_cubit.dart';
import 'package:rfid_project/features/scan/ui/widgets/scan_buttons.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class FinedProductPage extends StatefulWidget {
  const FinedProductPage({super.key, required this.actionType});

  final ActionType actionType;

  @override
  State<FinedProductPage> createState() => _FinedProductPageState();
}

class _FinedProductPageState extends State<FinedProductPage> {
  final controller = TextEditingController();

  late final ScanCubit cubit;

  Timer? t;

  @override
  void initState() {
    cubit = context.read<ScanCubit>();
    Future.delayed(Durations.extralong4, () {
      // cubit.setTempPower(3);
    });
    t = Timer.periodic(
      Duration(seconds: 1),
      (timer) => cubit
        ..getStatus()
        ..getData(),
    );

    super.initState();
  }

  @override
  void dispose() {
    t?.cancel();
    cubit.clear();
    // cubit.setTempPower(cubit.state.power);
    // loggerObject.w('setTempPower');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductsCubit, ProductsInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            if (state.result.isNotEmpty) {
              switch (widget.actionType) {
                case ActionType.move:
                  context.pushReplacementNamed(RouteName.moveProduct, extra: state.result.first);
                case ActionType.update:
                  context.pushReplacementNamed(RouteName.editAsset, extra: state.result.first);
                case ActionType.delete:
                  context.pushReplacementNamed(RouteName.deleteProduct, extra: state.result.first);
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorManager.mainColor,
        appBar: AppBarWidget(
          titleText: S.of(context).addProduct,
        ),
        body: BlocBuilder<ScanCubit, ScanInitial>(
          builder: (context, state) {
            if (state.loading) {
              return MyStyle.loadingWidget();
            }
            return Container(
              padding: EdgeInsets.all(20.0).r,
              decoration: BoxDecoration(
                color: AppColorManager.whit,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
              ),
              child: ListView(
                children: [
                  MyTextFormOutLineWidget(
                    controller: controller,
                    label: S.of(context).tag,
                    hint: S.of(context).tag,
                    helperText: S.of(context).ifYouWishToEnterTheStickerNumberManually,
                  ),
                  20.0.verticalSpace,
                  DrawableText.title(text: S.of(context).tag),
                  ...state.result.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          if (context.read<ProductsCubit>().state.loading) return;
                          controller.text = e;
                          context.read<ProductsCubit>().getData(tag: e);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0).r,
                          margin: EdgeInsets.symmetric(vertical: 7.0).r,
                          decoration: MyStyle.outlineBorder,
                          child: ListTile(
                            title: DrawableText(
                              text: e,
                            ),
                            subtitle: DrawableText(
                              text: state.labelNames[e]?.firstOrNull ?? '',
                              color: Colors.grey,
                              size: 12.0.sp,
                            ),
                            leading: RoundImageWidget(
                              url: state.labelNames[e]?.lastOrNull ?? '',
                              width: 30.0.r,
                              height: 30.0.r,
                            ),
                            trailing: ImageMultiType(
                              url: Icons.send,
                              height: 15.0.r,
                              width: 15.0.r,
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
              ),
            );
          },
        ),
        bottomNavigationBar: ScanButtons(
          search: BlocBuilder<ProductsCubit, ProductsInitial>(
            builder: (context, state) {
              return MyButton(
                loading: state.loading,
                text: S.of(context).searchForProduct,
                onTap: () {
                  context.read<ProductsCubit>().getData(tag: controller.text);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
