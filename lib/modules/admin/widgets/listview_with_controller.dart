import 'package:flutter/material.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/modules/admin/cubit/admin_cubit.dart';

import '../../../core/presentation/Palette.dart';

class ListViewWithController extends StatefulWidget {
  AdminCubit cubit;

  ListViewWithController({super.key, required this.cubit});

  @override
  State<ListViewWithController> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ListViewWithController> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print('init state');
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      widget.cubit.fetchIfHasData(widget.cubit.getUsersData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        print('cubit.isLastPage ${widget.cubit.isLastPage}');
        print('widget.cubit.hasmore ${widget.cubit.hasMore}');
        print(index);

        if (index < widget.cubit.users.length) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              subtitle: Text(
                  'Number of Companies: ${widget.cubit.users[index].companiesCount!}'),
              textColor: Colors.white,
              contentPadding: const EdgeInsets.all(20),
              tileColor: Palette.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              leading: const CircleAvatar(
                backgroundColor: Color(0xffEDF8F9),
                child: Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                ),
              ),
              title: Text(
                widget.cubit.users[index].uName!,
                style: context.textTheme.labelMedium!
                    .copyWith(color: Colors.black54),
              ),
              hoverColor: Colors.blueGrey,
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
                                          itemBuilder: (context, companyIndex) {
                                            return Text(
                                              widget
                                                  .cubit
                                                  .users[index]
                                                  .companies![companyIndex]
                                                  .cName!,
                                              style:
                                                  context.textTheme.bodyLarge,
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              myDivider,
                                          itemCount: widget.cubit.users[index]
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
          return widget.cubit.hasMore
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Text('');
        }
      },
      itemCount: widget.cubit.users.length + (widget.cubit.isLastPage ? 0 : 1),
    );
  }
}
