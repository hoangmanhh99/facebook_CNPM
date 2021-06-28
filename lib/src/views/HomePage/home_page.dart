import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/views/HomePage/FriendTab/friend_tabs.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/character_list_view.dart';
import 'package:Facebook_cnpm/src/views/HomePage/MenuTab/menu_tab.dart';
import 'package:Facebook_cnpm/src/views/HomePage/NotificationTab/notifications_tab.dart';
import 'package:Facebook_cnpm/src/views/HomePage/WatchTab/watch_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.grey[400],
          body: new NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    stretch: false,
                    backgroundColor: Colors.white,
                    floating: true,
                    pinned: true,
                    snap: false,
                    forceElevated: false,
                    automaticallyImplyLeading: false,
                    brightness: Brightness.light,
                    title: Text(
                      'facebook',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      Container(
                        decoration: new BoxDecoration(
                            color: Colors.grey[200], shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          color: Colors.black,
                          tooltip: 'search',
                          onPressed: () {
                            Navigator.pushNamed(context, "home_search_screen");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: new BoxDecoration(
                            color: Colors.grey[200], shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.facebookMessenger),
                          color: Colors.black,
                          // tooltip: 'Add new entry',
                          onPressed: () {
                            // Navigator.pushNamed(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                    elevation: 0.0,
                    bottom: TabBar(
                      indicatorColor: kColorBlue,
                      controller: _tabController,
                      unselectedLabelColor: kColorBlack,
                      labelColor: kColorBlue,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.home_outlined,
                            size: 30,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.people,
                            size: 30,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.ondemand_video,
                            size: 30,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.notifications,
                            size: 30,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  )
                ];
              },
              body: new TabBarView(controller: _tabController, children: [
                CharacterListView(),
                FriendsTab(),
                WatchTab(),
                NotificationTab(),
                MenuTab()
              ])),
        ));
  }
}
