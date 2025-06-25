import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/util/snack_bar_message.dart';
import 'package:rfid_project/core/widgets/my_button.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../asset/bloc/assets_cubit/assets_cubit.dart';
import '../../bloc/products_cubit/products_cubit.dart';
import '../../data/response/product_response.dart';

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductsCubit, ProductsInitial>(
          listenWhen: (p, c) => c.done && c.cubitCrud == CubitCrud.delete,
          listener: (context, state) {
            context.pop();
            NoteMessage.showSuccessSnackBar(message: 'تم بنجاح', context: context);
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorManager.mainColor,
        appBar: AppBarWidget(
          titleText: S.of(context).removeProduct,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0).r,
          decoration: BoxDecoration(
            color: AppColorManager.whit,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
          ),
          child: BlocBuilder<AssetsCubit, AssetsInitial>(
            builder: (context, cState) {
              return RefreshWidget(
                isLoading: cState.loading,
                onRefresh: () {
                  context.read<AssetsCubit>().getData(newData: true);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            decoration: MyStyle.outlineBorder,
                            padding: EdgeInsets.all(16.0).r,
                            child: Column(
                              children: [
                                10.0.verticalSpace,
                                DrawableText(
                                  matchParent: true,
                                  text: S.of(context).assetName,
                                  fontWeight: FontWeight.bold,
                                  drawableEnd: DrawableText(
                                    text: product.asset.name,
                                    color: Colors.grey,
                                  ),
                                ),
                                10.0.verticalSpace,
                                DrawableText(
                                  matchParent: true,
                                  text: S.of(context).entity,
                                  fontWeight: FontWeight.bold,
                                  drawableEnd: DrawableText(
                                    text: product.room.division.department.entity.name,
                                    color: Colors.grey,
                                  ),
                                ),
                                10.0.verticalSpace,
                                DrawableText(
                                  matchParent: true,
                                  text: S.of(context).department,
                                  fontWeight: FontWeight.bold,
                                  drawableEnd: DrawableText(
                                    text: product.room.division.department.name,
                                    color: Colors.grey,
                                  ),
                                ),
                                10.0.verticalSpace,
                                DrawableText(
                                  matchParent: true,
                                  text: S.of(context).division,
                                  fontWeight: FontWeight.bold,
                                  drawableEnd: DrawableText(
                                    text: product.room.division.name,
                                    color: Colors.grey,
                                  ),
                                ),
                                10.0.verticalSpace,
                                DrawableText(
                                  matchParent: true,
                                  text: S.of(context).room,
                                  fontWeight: FontWeight.bold,
                                  drawableEnd: DrawableText(
                                    text: product.room.name,
                                    color: Colors.grey,
                                  ),
                                ),
                                10.0.verticalSpace,
                                DrawableText(
                                  matchParent: true,
                                  text: S.of(context).room,
                                  fontWeight: FontWeight.bold,
                                  drawableEnd: DrawableText(
                                    text: product.room.name,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    MyButton(
                      onTap: () {
                        cState.cRequest.labels
                          ..clear()
                          ..add(cState.product.label);
                        context.read<AssetsCubit>().update(cState.product.id);
                      },
                      text: S.of(context).editProduct,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
