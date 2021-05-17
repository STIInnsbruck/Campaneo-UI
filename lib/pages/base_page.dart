import 'package:campaneo_app/pages/all_campaigns_page.dart';
import 'package:campaneo_app/pages/shop_page.dart';
import 'package:campaneo_app/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pages.dart';
import 'package:campaneo_app/pages/ranking_page.dart';
import 'package:campaneo_app/faker/fake_users.dart';
import 'package:campaneo_app/data/user.dart';
import 'package:campaneo_app/data/models.dart';
import 'package:campaneo_app/pages/active_campaigns_page.dart';
import 'package:campaneo_app/pages/live_tracker_page.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  Widget _selectedPage;
  List<User> userList = new FakeUsers().getFakeUserList();
  User currentUser = new User("You", 0, 0);
  List<dynamic> newCampaignsList = new List();



  _BasePageState() {
    userList.add(currentUser);
    _selectedPage = HomePage(changeScreen, this.currentUser, this.newCampaignsList);
    //_selectedPage = AllCampaignsPage();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double iconSize = height / 10;

    return Scaffold(
      body: _selectedPage,
      bottomNavigationBar: SizedBox(
        height: height / 10,
        child: BottomAppBar(
          child: Row(
            children: [
              Spacer(),
              IconButton(
                padding: EdgeInsets.all(0), //center icon in IconButton
                iconSize: iconSize,
                icon: Icon(Icons.home),
                onPressed: () => { changeScreen(0) },
              ),
              Spacer(),
              IconButton(
                padding: EdgeInsets.all(0), //center icon in IconButton
                iconSize: iconSize,
                icon: Icon(Icons.shopping_cart),
                onPressed: () => { changeScreen(2) },
              ),
              Spacer(),
              IconButton(
                padding: EdgeInsets.all(0), //center icon in IconButton
                iconSize: iconSize,
                icon: Icon(Icons.settings),
                onPressed: () => { changeScreen(3) },
              ),
              Spacer(flex: 20),
              Text(_currentTime(), style: TextStyle(color: Colors.white, fontSize: height / 12)),
              Spacer()
            ],
          ),
        ),
      )
    );
  }

  String _currentTime() {
    var now = DateTime.now();
    String time = DateTime.parse(now.toIso8601String()).toLocal().toString();
    time = time.substring(11, 16);
    return '$time';
  }

  changeScreen(x) {
    setState(() {
      _selectedIndex = x;
      switch(_selectedIndex) {
        case 0:
          _selectedPage = HomePage(changeScreen, currentUser, newCampaignsList);
          break;
        case 1:
          _selectedPage = AllCampaignsPage(currentUser, newCampaignsList);
          break;
        case 2:
          _selectedPage = ShopPage(userList, currentUser);
          break;
        case 3:
          _selectedPage = SettingsPage();
          break;
        case 4:
          _selectedPage = RankingPage(userList, currentUser);
          break;
        case 5:
          _selectedPage = ActiveCampaignsPage(currentUser, changeScreen);
          break;
        case 6:
          _selectedPage = LiveTrackerPage(currentUser);
      }
    });
  }
}