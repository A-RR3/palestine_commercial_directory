import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/modules/admin/cubit/admin_cubit.dart';
import 'package:videos_application/modules/admin/cubit/states.dart';
import 'package:videos_application/modules/admin/widgets/listview_with_controller.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AdminCubit cubit = AdminCubit.get(context);

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('All Users ', style: context.textTheme.headlineSmall),
            ),
            body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: cubit.users.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListViewWithController(cubit: cubit),
                      )),
          ),
        );
      },
    );
  }
}
