import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../generated/assets.dart';
import '../../../asset/bloc/assets_cubit/assets_cubit.dart';

class ScanButtons extends StatelessWidget {
  const ScanButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
          5.0.verticalSpace,
          BlocBuilder<ProductsCubit, ProductsInitial>(
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
        ],
      ),
    );
  }
}
