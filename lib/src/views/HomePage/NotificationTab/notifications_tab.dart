import 'dart:convert';

import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Facebook_cnpm/src/views/HomePage/NotificationTab/notifications_controller.dart';
import 'package:Facebook_cnpm/src/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab>
    with AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  NotificationController notificationController = new NotificationController();

  List<dynamic> notifications = [];

  bool isLoading = false;

  static const _pageSize = 2;

  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      child: RefreshIndicator(
        onRefresh: () async {
          refreshKey.currentState?.show(atTop: false);
          Future.sync(() => _pagingController.refresh());
          setState(() {
            isLoading = false;
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notification",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                        tooltip: 'search',
                        onPressed: () {
                          Navigator.pushNamed(context, 'home_search_screen');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            PagedSliverList(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                    itemBuilder: (context, item, index) {
                      return null;
                    },
                    firstPageProgressIndicatorBuilder: (_) => LoadingNewFeed()))
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
