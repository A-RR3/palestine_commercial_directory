import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/asset_keys.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/shared/network/remote/end_points.dart';
import '../../../core/values/lang_keys.dart';
import '../../../models/user_model.dart';
import '../screens/users/cubit/users_cubit.dart';

class ListViewWithController extends StatelessWidget {
  UsersCubit cubit;
  List<User> users;

  ListViewWithController({super.key, required this.cubit, required this.users});

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? Center(child: Text('No Users found'))
        : ListView.builder(
            itemBuilder: (context, index) {
              print('cubit.isLastPage ${cubit.isLastPage}');
              print('widget.cubit.hasmore ${cubit.hasMore}');
              print(index);

              if (index < users.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListTile(
                    minTileHeight: 80,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    subtitle: Text(LangKeys.COMPANIES_COUNT.tr(namedArgs: {
                      'number': '${users[index].companiesCount!}'
                    })),
                    leading: users[index].uImage != null
                        ? Container(
                            width: 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40)),
                            child: ClipOval(
                                child: Image.network(
                              '${EndPointsConstants.usersStorage}${users[index].uImage}',
                              fit: BoxFit.cover,
                            )),
                          )
                        : leading,
                    title: Text(
                      users[index].uName!,
                      style: context.textTheme.labelMedium,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            elevation: 8,
                            backgroundColor: const Color(0xffEDF8F9),
                            insetPadding: const EdgeInsets.all(20),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'user companies: ',
                                      style: context.textTheme.headlineSmall,
                                    ),
                                    vSpace(),
                                    const Divider(
                                      thickness: 1.5,
                                    ),
                                    vSpace(),
                                    SizedBox(
                                        height: context.deviceSize.height * .5,
                                        width: context.deviceSize.width * .7,
                                        child: Center(
                                            child: ListView.separated(
                                                itemBuilder:
                                                    (context, companyIndex) {
                                                  return Text(
                                                    users[index]
                                                        .companies![
                                                            companyIndex]
                                                        .cName!,
                                                    style: context
                                                        .textTheme.bodyLarge,
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        myDivider,
                                                itemCount: users[index]
                                                    .companiesCount!))),
                                  ]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return cubit.hasMore
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text('');
              }
            },
            itemCount: users.length + (cubit.isLastPage ? 0 : 1),
          );
  }
}

Widget get leading => Container(
      width: 60,
      height: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      child: ClipOval(
        child: SvgPicture.asset(
          AssetsKeys.getIconPath(AssetsKeys.DEFAULT_PERSON),
          fit: BoxFit.cover,
        ),
      ),
    );
