import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campaneo_app/data/user.dart';
import 'dart:math';

import '../data/campaign_fetch.dart';

class RankingPage extends StatelessWidget {
  static const String routeName = '/ranking';
  static const String pageTitle = 'Ranking';

  List<User> userList;
  User currentUser;

  RankingPage(this.userList, this.currentUser);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenSize = min(height, width);

    this.userList.sort((a,b) => b.getCompletedCampaigns.compareTo(a.getCompletedCampaigns));
    int currentUserIndex = this.userList.indexOf(this.currentUser);
    return Container(
      child: ListView.builder(
        itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("${userList[index].getName}", style: TextStyle(fontSize: screenSize / 20)),
              leading: Icon(Icons.person, size: screenSize / 15),
              trailing: Text("Campaigns:    ${userList[index].getCompletedCampaigns}", style: TextStyle(fontSize: screenSize / 20)),
              tileColor: index==currentUserIndex? Colors.green : null,
            );
          },
      ),
    );
  }
}
