import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:rfid_project/core/widgets/spinner_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import '../../bloc/products_cubit/products_cubit.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductsCubit, ProductsInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
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
          child: BlocBuilder<ProductsCubit, ProductsInitial>(
            builder: (context, state) {
              return RefreshWidget(
                isLoading: state.loading,
                onRefresh: () {
                  context.read<ProductsCubit>().getData(newData: true);
                },
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    MyTextFormOutLineWidget(
                      label: S.of(context).assetName,
                      hint: S.of(context).assetName,
                    ),
                    SpinnerWidget(
                      items: [],
                      hintText: S.of(context).department,
                      hintLabel: 'department',
                    ),
                    SpinnerWidget(
                      items: [],
                      hintText: S.of(context).division,
                      hintLabel: 'Division',
                    ),
                    SpinnerWidget(
                      items: [],
                      hintText: S.of(context).room,
                      hintLabel: 'Room',
                    ),
                    MyTextFormOutLineWidget(
                      label: S.of(context).assetSite,
                      hint: '(eg: Room No. 1)',
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
