import 'dart:async';

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
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:rfid_project/features/asset/ui/widgets/add_asset_info.dart';
import 'package:rfid_project/features/product/bloc/products_cubit/products_cubit.dart';
import 'package:rfid_project/features/scan/bloc/scan_cubit/scan_cubit.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import '../../../asset/bloc/assets_cubit/assets_cubit.dart';

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
  void dispose() {
    cubit.clear();
    cubit.dispose();
    t?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    cubit = context.read<ScanCubit>();

    t = Timer.periodic(
      Duration(seconds: 1),
      (timer) => cubit
        ..getStatus()
        ..getData(),
    );

    super.initState();
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
        body: Container(
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
              DrawableText.title(text: 'Tag id'),
              ...['EB23Z3KTC5X1BAEGUEALTZOY'].map(
                (e) {
                  return BlocBuilder<ProductsCubit, ProductsInitial>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          if (state.loading) return;
                          controller.text = e;
                          context.read<ProductsCubit>().getData(tag: e);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0).r,
                          margin: EdgeInsets.symmetric(vertical: 7.0).r,
                          decoration: MyStyle.outlineBorder,
                          child: DrawableText(
                            text: e,
                            matchParent: true,
                            drawableEnd: ImageMultiType(
                              url: Icons.send,
                              height: 15.0.r,
                              width: 15.0.r,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ImageMultiType(
                url: Assets.iconsHotspot,
              ),
            ],
          ),
        ),
        bottomNavigationBar: ,
      ),
    );
  }
}
