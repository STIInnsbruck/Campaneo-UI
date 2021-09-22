import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campaneo_app/widgets/campaign_tile.dart';
import 'package:campaneo_app/data/user.dart';
import 'dart:html' as html;

import '../data/campaign_fetch.dart';

class ActiveCampaignsPage extends StatefulWidget {
  static const String routeName = '/activecampaigns';
  static const String pageTitle = 'ActiveCampaigns';
  User currentUser;
  Function(int) changeScreen;

  ActiveCampaignsPage(this.currentUser, this.changeScreen);

  @override
  _ActiveCampaignsPageState createState() => _ActiveCampaignsPageState();
}

class _ActiveCampaignsPageState extends State<ActiveCampaignsPage> {
  List<User> userList;
  bool liveView = false;

  @override
  Widget build(BuildContext context) {
    return widget.currentUser.acceptedCampaigns.length>0? Stack(
      children: [
        Scrollbar(
          child: GridView.builder(
            itemCount: widget.currentUser.acceptedCampaigns.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.85
            ),
            itemBuilder: (context, int index) =>
                CampaignTile(context, index, widget.currentUser.acceptedCampaigns[index], widget.currentUser, updateList),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {
              print("LIVE VIEW PRESSED.");
              setState(() {
                html.window.open('https://stiinnsbruck.github.io/CampaNeoViz/campaign_network_d3/dist/index.html', "live tracker");
                /**if(Platform.isAndroid) {
                    liveView = !liveView;
                    widget.changeScreen(6);
                    } else {
                    html.window.open('https://stiinnsbruck.github.io/CampaNeoViz/campaign_network_d3/dist/index.html', "live tracker");
                    }*/
              });
              },
            child: liveView == false ?
              Text("LIVE VIEW", style: TextStyle(fontSize: 40))
                :
              Text("TILE VIEW", style: TextStyle(fontSize: 40)),
          ),
        )
      ],
    ) :
    Center(
      child: Text("You are currently not participating in any campaign. Have a look in the New Campaigns-page to participate in a campaign.", style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
    );
  }

  updateList() {
    setState(() {
      widget.currentUser.acceptedCampaigns = widget.currentUser.acceptedCampaigns;
    });
  }
  //testpush
}
