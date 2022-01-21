import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campaneo_app/widgets/campaign_tile.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:campaneo_app/data/models.dart';
import 'package:campaneo_app/data/user.dart';

import '../data/campaign_fetch.dart';

class AllCampaignsPage extends StatefulWidget {
  static const String routeName = '/allcampaigns';
  static const String pageTitle = 'AllCampaigns';
  User currentUser;
  List<dynamic> newCampaignsList;


  AllCampaignsPage(this.currentUser, this.newCampaignsList);

  @override
  _AllCampaignsPageState createState() => _AllCampaignsPageState();
}

class _AllCampaignsPageState extends State<AllCampaignsPage> {
  List<User> userList;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        itemCount: widget.currentUser.newCampaigns.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.85
        ),
        itemBuilder: (context, int index) =>
            CampaignTile(context, index, widget.currentUser.newCampaigns[index], widget.currentUser, updateList),
      ),
    );

    /**return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Scrollbar(
        child: GridView.builder(
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.85
        ),
        itemBuilder: (BuildContext context, int index) => CampaignTile('Verkehrsanalyse in Innsbruck $index')
        ),
        ),
        );*/
  }

  void setOldVersionCampaigns() {
    setState(() {
      Address tyrolAddr = Address(
          country: "Austria",
          city: "Innsbruck",
          number: "1",
          street: "Haupstraße 1"
      );

      Organization tyrolgov = Organization(
          name: "Tyrol Government",
          email: "tirolatgov.at",
          address: tyrolAddr,
          phone: "+43512 9079186"
      );

      Campaign driveSmart = new Campaign(
          id: "Drive Smart",
          name: "Drive Smart",
          description: "New investments in sidealks, bike lanes, and other improvements are supporting more walking and bicycling in Tyrol. Officials are making safety a priority since pedestrians and bicyclists currently account for more than a quarter of the total traffic fatalities in the region.",
          gdprClassification: "classification",
          imageUrl: "imageUrl",
          organization: tyrolgov,
          validFrom: "10.02.2021",
          validTo: "10.02.2022"
      );
    });
  }

  updateList() {
    setState(() {
      widget.currentUser.newCampaigns = widget.currentUser.newCampaigns;
    });
  }

}
