import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/duration_items.dart';
import 'package:demo/core/utilty/icon_items.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/home_screen/model/data_model.dart';
import 'package:demo/product/home_screen/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int defaultPage = 1;
  int totalPage = 2;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeViewModel>().firstGetUsers();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreItems(totalPage);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreItems(int totalPage) async {
    printf("$defaultPage");
    if (defaultPage <= totalPage) {
      defaultPage++;
      context.read<HomeViewModel>().loadGetUsers(defaultPage);
    } else {
      showSnackbar(
        context,
        "Başka Kullanıcı Bulunamadı !",
        DurationItem.medium,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              context.router.pushNamed(RouterItem.setting.str());
            },
            icon: IconItem.setting.str(),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _listView(
              context.watch<HomeViewModel>().userList,
              context.watch<HomeViewModel>().isFirstLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView(List<User> userList, bool isLoading) {
    return isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        //  ListView.builder(
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: PaddingItem.small.str() / 2,
        //         child: Card(
        //           child: Padding(
        //             padding: PaddingItem.small.str() / 2,
        //             child: Row(
        //               children: [
        //                 ClipOval(
        //                   child: SizedBox(
        //                     width: context.width / 5,
        //                     height: context.width / 5,
        //                     child: Shimmer.fromColors(
        //                       baseColor: Colors.black26,
        //                       highlightColor: Colors.grey.shade300,
        //                       period: DurationItem.small.str(),
        //                       child: Container(
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: PaddingItem.leftMedium.str(),
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         "${userList[index].firstName} ${userList[index].lastName}",
        //                         style: Theme.of(context).textTheme.titleSmall,
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   )
        : ListView.builder(
            controller: _scrollController,
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: PaddingItem.small.str() / 2,
                child: Card(
                  child: Padding(
                    padding: PaddingItem.small.str() / 2,
                    child: Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: userList[index].avatar ?? "",
                            placeholder: (context, url) => SizedBox(
                              width: context.width / 5,
                              height: context.width / 5,
                              child: Shimmer.fromColors(
                                baseColor: Colors.black26,
                                highlightColor: Colors.grey.shade300,
                                period: DurationItem.small.str(),
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              size: context.height / 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: PaddingItem.leftMedium.str(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userList[index].email ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "${userList[index].firstName} ${userList[index].lastName}",
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
