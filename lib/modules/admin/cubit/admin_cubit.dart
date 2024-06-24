import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/admin/cubit/states.dart';
import 'package:videos_application/modules/admin/screens/companies/companies_screen.dart';
import 'package:videos_application/modules/admin/screens/users/users_screen.dart';

import '../screens/companies/categories_screen.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialAdminState());

  static AdminCubit get(context) => BlocProvider.of(context);

  List screens = [UsersScreen(), CategoriesScreen()];
}
