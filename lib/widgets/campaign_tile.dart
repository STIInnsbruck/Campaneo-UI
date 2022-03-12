import 'dart:ui';

import 'package:campaneo_app/widgets/campaign_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:campaneo_app/widgets/status_widget.dart';
import 'package:campaneo_app/widgets/active_campaign_info_dialog.dart';
import 'package:campaneo_app/data/models.dart';
import 'package:campaneo_app/data/user.dart';

/// This widget acts as a tile button for the homepage screen. Where other
/// widgets can be displayed in.

class CampaignTile extends StatefulWidget {

  Campaign campaign;
  List newCampaignsList;
  User currentUser;
  int index;
  BuildContext context;
  Function callback;

  CampaignTile(this.context, this.index, this.campaign, this.currentUser, this.callback);

  @override
  _CampaignTileState createState() => _CampaignTileState();
}

class _CampaignTileState extends State<CampaignTile> {
  AssetImage image;

  Status status;

  List<User> userList;

  @override
  Widget build(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Ink(
        decoration: BoxDecoration(
          color: HexColor("#3C3C3C"),
          border: Border.all(color: HexColor("#C4C4C4"), width: 1),
          image: DecorationImage(
            image: AssetImage('assets/images/campaign-back.png'),
            fit: BoxFit.cover
          ),
        ),
        child: InkWell(
          child: Stack(
            children: <Widget>[
              Center(
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    height: height * 0.15,
                    width: double.maxFinite,
                    color: Colors.grey,
                  ),
                ),
              ),
              Center(
                child: Text(this.widget.campaign.name, style: TextStyle(color: Colors.white, fontSize: height / 20), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.center),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 2, bottom: 2),
                  child: StatusWidget(this.widget.campaign.status),
                ),
              ),
            ],
          ),
          onTap: () => { showCorrectDialog() },
        ),
      ),
    );
  }

  bool isActiveCampaign() {
    print("Active campaign: ${widget.campaign.status}");
    if(widget.campaign.status == Status.Accepted) {
      return true;
    } else {
      return false;
    }
  }

  void updateStatus(Status status) {
    setState(() {
      this.widget.campaign.status = status;
      //this.widget.currentUser.newCampaigns[this.widget.index].status = status;
      if(status == Status.Rejected) {
        this.widget.currentUser.rejectedCampaigns.add(this.widget.campaign);
        widget.callback();
      }
      else if(status == Status.Accepted) {
        widget.callback();
        //this.widget.currentUser.acceptedCampaigns.add(this.widget.campaign);
      }

    });
  }

  showCampaignInfo(BuildContext context, User currentUser, List newCampaignsList) {
    showDialog(
        context: context,
        builder: (context) => CampaignInfoDialog(context, widget.campaign, currentUser, widget.index, updateStatus)
    );
  }

  showActiveCampaignInfo(BuildContext context, User currentUser) {
    showDialog(
      context: context,
      builder: (context) => ActiveCampaignInfoDialog(
          widget.campaign, context, currentUser, widget.newCampaignsList, widget.index, updateStatus
      )
    );
  }

  showCorrectDialog() {
    if(isActiveCampaign() == true) {
      showActiveCampaignInfo(context, widget.currentUser);
    } else {
      showCampaignInfo(context, widget.currentUser, widget.newCampaignsList);
    }
  }
}