import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../../database/import_db.dart';
import '../../../profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../bloc/home_cubit/home_cubit.dart';
import '../widget/screens/menu_screen.dart';
import 'home_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomeCubit get cubit => context.read<HomeCubit>();

  @override
  void dispose() {
    cubit.state.controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<GetMeCubit>().getData(newData: true);
    importNewDatabaseFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        zeroHeight: true,
        onPopInvoked: (isPop, result) => cubit.jumpPage(0),
        canPop: cubit.canPop,
      ),
      body: BlocListener<GetMeCubit, GetMeInitial>(
        listener: (context, state) {},
        child: BlocBuilder<DeleteAccountCubit, DeleteAccountInitial>(
          buildWhen: (p, c) => c.done,
          builder: (context, state) {
            if (state.loading) {
              return MyStyle.loadingWidget();
            }
            return BlocBuilder<HomeCubit, HomeInitial>(
              builder: (context, state) {
                return PageView(
                  controller: state.controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const HomeScreen(),
                    const MenuScreen(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
