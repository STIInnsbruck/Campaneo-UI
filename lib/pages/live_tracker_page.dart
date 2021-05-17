import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campaneo_app/data/user.dart';


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
  Widget build(BuildContext context) {
    return Container();
  }
}
