import 'package:flutter/material.dart';
import '../widgets/post.dart';
import '../widgets/feed.dart';
import '../location/location.dart';
import '../widgets/homepage.dart';
import '../global/globals.dart' as globals;

class Screen extends StatefulWidget {
  @override
  _Screen createState() => new _Screen();
}

class _Screen extends State<Screen>
    with SingleTickerProviderStateMixin, ChangeNotifier {
  double _sliderValue = 10.0;
  TabController _tabController;
  var widgetList;
  var homeRefresh = ChangeNotifier();
  var feedRefresh = ChangeNotifier();

  List<Tab> tabList = <Tab>[
    new Tab(text: 'post'),
    new Tab(text: 'popular'),
    new Tab(text: 'newest'),
    new Tab(text: 'saved'),
    new Tab(text: 'archived'),
  ];

  @override
  void initState() {
    widgetList = <Widget>[
      Post(),
      Feed(feedRefresh),
      Location(),
      HomePage(homeRefresh),
      Feed(feedRefresh),
    ];

    _tabController = new TabController(
      initialIndex: 1,
      vsync: this,
      length: tabList.length,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new TabBarView(
        controller: _tabController,
        children: tabList.map((Tab tab) {
          return new Center(
            child: widgetList[tabList.indexOf(tab)],
          );
        }).toList(),
      ),
      bottomNavigationBar: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 20.0),
            child: new SliderTheme(
              data: ThemeData().sliderTheme.copyWith(
                    showValueIndicator: ShowValueIndicator.always,
                  ),
              child: Slider(
                divisions: 25,
                min: 0.0,
                max: 25.0,
                onChanged: (response) {
                  setState(() {
                    //Prevent double printing.
                    if (_sliderValue != response) {
                      _sliderValue = response;
                      globals.distance = response;
                    }
                  });
                },
                onChangeEnd: (response) {
                  if (_tabController.index == 3) {
                    homeRefresh.notifyListeners();
                  }
                  if (_tabController.index == 1) {
                    feedRefresh.notifyListeners();
                  }
                },
                value: _sliderValue,
                label: _sliderValue.round().toString(),
              ),
            ),
          ),
          new Material(
            color: Theme.of(context).primaryColor,
            child: new TabBar(
              controller: _tabController,
              tabs: tabList,
            ),
          ),
        ],
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return new DefaultTabController(
//       length: tabNames.length,
//       child: new Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: new TabBarView(
//           controller: _tabController,
//           // children: new List<Widget>.generate(tabNames.length, (int index) {
//           //   return new Center(
//           //     child: tabContent[index],
//           //   );
//           children:
//           ),
//         ),
// bottomNavigationBar: new Column(
//   mainAxisSize: MainAxisSize.min,
//   crossAxisAlignment: CrossAxisAlignment.stretch,
//   children: [
//     new Container(
//       padding: new EdgeInsets.symmetric(horizontal: 20.0),
//       child: new SliderTheme(
//         data: ThemeData().sliderTheme.copyWith(
//               showValueIndicator: ShowValueIndicator.always,
//             ),
//         child: Slider(
//           divisions: 15,
//           min: 0.0,
//           max: 15.0,
//           onChanged: (response) {
//             setState(() => _sliderValue = response);
//           },
//           value: _sliderValue,
//           label: _sliderValue.round().toString(),
//         ),
//       ),
//     ),
//     new Material(
//       color: Theme.of(context).primaryColor,
//       child: new TabBar(
//         isScrollable: true,
//         tabs: new List.generate(tabNames.length, (index) {
//           return new Tab(text: tabNames[index].toUpperCase());
//         }),
//       ),
//     ),
//   ],
// ),
//       ),
//     );
//   }
// }
