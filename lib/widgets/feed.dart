import 'package:flutter/material.dart';
import '../helper/feed_handler.dart';
import '../widgets/tile.dart';
import '../unit/unit.dart';
import '../global/globals.dart' as globals;
import 'package:geolocation/geolocation.dart';

class Feed extends StatefulWidget {
  final refresh;
  Feed(this.refresh);

  @override
  _Feed createState() => new _Feed();
}

// class _Feed extends State<Feed> with ChangeNotifier {}

class _Feed extends State<Feed> with ChangeNotifier {
  List<Unit> items = [];
  var counter = 0;
  var _scrollController = new ScrollController();
  var isPerformingRequest = false;
  var max = 10;
  var fh = new FeedHandler();
  var latitude;
  var longtitude;

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getData();
      }
    });
    widget.refresh.addListener(_refreshData);
  }

  @override
  void dispose() {
    super.dispose();
    widget.refresh.removeListener(_refreshData);
    _scrollController.dispose();
  }

  _refreshData() {
    counter = 0;
    setState((){
      items = [];
      _getData();
    });
  }

  _getData() async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      List<Unit> newEntries = [];

      final GeolocationResult result =
          await Geolocation.isLocationOperational();
      if (result.isSuccessful) {
        Geolocation
            .singleLocationUpdate(accuracy: LocationAccuracy.best)
            .listen((response) async {
          if (response.isSuccessful) {
            latitude = response.location.latitude.toString();
            longtitude = response.location.longitude.toString();
            print(longtitude);
            print(latitude);

            await fh
                .feed(globals.distance, counter, latitude, longtitude)
                .then((response) {
              if (response.isNotEmpty) {
                newEntries.addAll(response);
                counter++;
              } else {
                print("empty");
              }
            });

            if (newEntries.isEmpty) {
              double edge = 50.0;
              double offsetFromBottom =
                  _scrollController.position.maxScrollExtent -
                      _scrollController.position.pixels;
              if (offsetFromBottom < edge) {
                _scrollController.animateTo(
                    _scrollController.offset - (edge - offsetFromBottom),
                    duration: new Duration(milliseconds: 500),
                    curve: Curves.easeOut);
              }
            }
            setState(() {
              items.addAll(newEntries);
              isPerformingRequest = false;
            });
          }
        });
      }
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _buildProgressIndicator();
        } else {
          return Tile(items[index]);
        }
      },
      controller: _scrollController,
    );
  }
}
