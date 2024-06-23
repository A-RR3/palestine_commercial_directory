import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/admin/screens/companies/cubit/companies_states.dart';
import 'package:videos_application/modules/home/cubit/home_states.dart';
import 'package:videos_application/shared/network/remote/end_points.dart';

import '../../../../../core/utils/mixins/cancel_token_mixin.dart';
import '../../../../../core/values/constants.dart';
import '../../../../../models/categories_model.dart';
import '../../../../../models/company_model.dart';
import '../../../../../shared/network/remote/dio_helper.dart';

class CompaniesCubit extends Cubit<CompaniesStates> with CancelTokenMixin {
  CompaniesCubit() : super(CompaniesInitialState());

  static CompaniesCubit get(context) => BlocProvider.of(context);

  List<CompanyModel> companies = [];

  void getCompaniesData(int categoryId) async {
    emit(CompaniesInitialState());
    companies = [];
    await DioHelper.getData(
      url: '${COMPANIES}/${categoryId}',
      token: userToken,
    ).then((response) {
      print(response);
      var data = response?.data;
      if (data != null) {
        companies =
            List<CompanyModel>.from(data.map((e) => CompanyModel.fromJson(e)));
        emit(CompaniesFetchDataSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(CompaniesFetchDataErrorState());
    });
  }

  List<CategoryModel> categories = [];

  void getCategoriesData() async {
    emit(CategoriesLoadingDataState());

    await DioHelper.getData(url: CATEGORIES, token: userToken).then((response) {
      var data = response?.data;
      if (data != null) {
        categories = List<CategoryModel>.from(
            data.map((e) => CategoryModel.fromJson(e)));
        // print(categories);
      }
      emit(CategoriesFetchDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesFetchDataErrorState());
    });
  }
}
