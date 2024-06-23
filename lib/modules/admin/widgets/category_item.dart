import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/models/categories_model.dart';
import 'package:videos_application/modules/admin/screens/companies/cubit/companies_cubit.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';
import '../../../core/utils/navigation_services.dart';
import '../../../core/values/cache_keys.dart';
import '../screens/companies/companies_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, required this.cubit});
  final CategoryModel category;
  final CompaniesCubit cubit;

  @override
  Widget build(BuildContext context) {
    String lang = CacheHelper.getData(CacheKeys.lang.name);
    return InkWell(
        onTap: () {
          cubit.getCompaniesData(category.id!);
          NavigationServices.navigateTo(
              context,
              CompaniesScreen(
                categoryId: category.id!,
                cubit: cubit,
              ));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: category.cImage!,
                  imageErrorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Center(
                      child: Container(color: Colors.blueGrey),
                    );
                  },
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                lang == enCode ? category.cNameEn! : category.cNameAr!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    shadows: textShadow,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ));
  }
}
