import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campaneo_app/data/user.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';


class LiveTrackerPage extends StatefulWidget {
  static const String routeName = '/livetracker';
  static const String pageTitle = 'LiveTracker';
  User currentUser;

  LiveTrackerPage(this.currentUser);

  @override
  _LiveTrackerPageState createState() => _LiveTrackerPageState();
}

class _LiveTrackerPageState extends State<LiveTrackerPage> {
  List<User> userList;

  @override
  void initState() {
    super.initState();


    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: 'https://stiinnsbruck.github.io/CampaNeoViz/campaign_network_d3/dist/index.html',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
