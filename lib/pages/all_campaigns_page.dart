import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campaneo_app/widgets/campaign_tile.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:campaneo_app/data/models.dart';
import 'package:campaneo_app/data/user.dart';
import 'package:campaneo_app/data/rest_api.dart';

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
  RestApiClient apiClient = new RestApiClient();
  List<Campaign> campaigns = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder(
        future: apiClient.fetchAllCampaigns(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            campaigns = snapshot.data as List<Campaign>;
            for (int i = 0; i < campaigns.length; i++) {
              widget.currentUser.newCampaigns.add(campaigns[i]);
            }
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
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  updateList() {
    setState(() {
      widget.currentUser.newCampaigns = widget.currentUser.newCampaigns;
    });
  }

}
