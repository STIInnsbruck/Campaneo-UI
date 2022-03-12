import 'dart:ui';
import 'package:campaneo_app/widgets/information_selection_dialog.dart';
import 'package:campaneo_app/widgets/queryable_campaign_details.dart';
import 'package:campaneo_app/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:campaneo_app/data/models.dart';
import 'package:campaneo_app/data/user.dart';

/// This widget acts as a tile button for the homepage screen. Where other
/// widgets can be displayed in.

class CampaignInfoDialog extends StatelessWidget {

  Campaign campaign;
  BuildContext context;
  List<User> userList;
  User currentUser;
  int index;
  Function statusCallback;

  CampaignInfoDialog(this.campaign, this.context, this.currentUser, this.index, this.statusCallback);

  @override
  Widget build(context) {
    return Dialog(
      shape: BeveledRectangleBorder(),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.85,
      width: width * 0.80,
      decoration: BoxDecoration(
        color: HexColor("#3C3C3C"),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(this.campaign.name, style: TextStyle(fontSize: height / 20, color: Colors.white70), textAlign: TextAlign.center),
                Text(this.campaign.organization.name, style: TextStyle(fontSize: height / 40, color: Colors.white70)),
                Container(
                    height: height * 0.3,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(this.campaign.description, style: TextStyle(fontSize: height / 30, color: Colors.white70)),
                        scrollDirection: Axis.vertical,
                      ),
                    )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      campaignerDetailRow(Icons.home, this.campaign.organization.address.getPrintableAddress(), height),
                      campaignerDetailRow(Icons.phone, this.campaign.organization.phone, height),
                      campaignerDetailRow(Icons.mail_outline, this.campaign.organization.email, height)
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    continueButton(context, height, width),
                    isAcceptedCampaign()? revokeButton(context, height, width) : declineButton(context, height, width)
                  ],
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white70, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              )
          ),
        ],
      ),
    );
  }

  bool isAcceptedCampaign() {
    if(currentUser.acceptedCampaigns.length > 0) {
      if (currentUser.acceptedCampaigns.any((element) => element.id == campaign.id) == true) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Widget campaignerDetailRow(IconData iconData, String text, height) {
    return Row(
      children: [
        Icon(iconData),
        Container(width: 5),
        Text(text, style: TextStyle(fontSize: height / 40, color: Colors.white70)),
      ],
    );
  }

  Widget continueButton(BuildContext context, double height, double width) {
    return Container(
      height: height * 0.15,
      width: width * 0.25,
      child: Material(
        color: Colors.green,
        child: InkWell(
          child: Center(
            child: Text("CONTINUE", style: TextStyle(fontSize: width / 18)),
          ),
          onTap: () => { showInformationSelection(context, currentUser, statusCallback, campaign) },
        ),
      ),
    );
  }

  Widget declineButton(BuildContext context, double height, double width) {
    return Container(
      height: height * 0.15,
      width: width * 0.25,
      child: Material(
        color: Colors.red,
        child: InkWell(
          child: Center(
            child: Text("DECLINE", style: TextStyle(fontSize: width / 18)),
          ),
          onTap: () {
            campaign.status = Status.Rejected;
            statusCallback(Status.Rejected);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget revokeButton(BuildContext context, double height, double width) {
    return Container(
      height: height * 0.15,
      width: width * 0.25,
      child: Material(
        color: Colors.deepOrangeAccent,
        child: InkWell(
          child: Center(
            child: Text("REVOKE", style: TextStyle(fontSize: height / 10)),
          ),
          onTap: () {
            campaign.status = Status.Rejected;
            currentUser.acceptedCampaigns.removeAt(index);
            statusCallback(Status.Rejected);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  showInformationSelection(BuildContext context, userList, Function callback, Campaign campaign) {
    showDialog(
        context: context,
        builder: (BuildContext context) => InformationSelectionDialog(userList, callback, index, campaign)
    );
  }

}