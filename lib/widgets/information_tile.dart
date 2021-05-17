import 'dart:ui';
import 'dart:math';
import 'package:campaneo_app/data/models.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:campaneo_app/widgets/information_detail_dialog.dart';
import 'package:campaneo_app/data/user.dart';
import 'package:campaneo_app/widgets/status_widget.dart';


/// This widget acts as a tile button for the homepage screen. Where other
/// widgets can be displayed in.

class InformationTile extends StatelessWidget {

  var random = new Random();
  final IconData iconData;
  Function(int) addPoints;
  int points;
  Color color = HexColor("#C4C4C4");
  bool selected = false;
  User currentUser;
  int campaignListIndex;
  int index;
  Campaign currentCampaign;

  InformationTile(this.iconData, this.addPoints, this.currentUser, this.campaignListIndex, this.index, this.currentCampaign) {
    this.points = (random.nextDouble() * (10 - 1) + 1).floor();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: HexColor("#3C3C3C"), width: 5),
      ),
      child: Material(
        color: currentCampaign.sensorList[index].selected? Colors.green : HexColor("#C4C4C4"),
        child: InkWell(
          splashColor: Colors.white70,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(this.iconData, size: width / 10, color: HexColor("#3C3C3C")),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${currentCampaign.sensorList[index].points} PTS", style: TextStyle(fontSize: height / 20, color: HexColor("#3C3C3C"))),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.info, size: height / 20, color: HexColor("#3C3C3C")),
                        padding: EdgeInsets.all(0),
                        onPressed: () => {showCampaignInfo(context)}),
                    //Container(width: 10)
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            if(currentCampaign.status == Status.Accepted) {
              print("not editable");
            } else {
              currentCampaign.sensorList[index].selected = !currentCampaign.sensorList[index].selected;
              if(currentCampaign.sensorList[index].selected == true) {
                this.addPoints(10);
              } else {
                this.addPoints(-10);
              }
              (context as Element).markNeedsBuild();
            }
          },
        ),
      ),
    );
  }

  showCampaignInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => InformationDetailDialog(
            "${currentCampaign.sensorList[index].name}",
            "${currentCampaign.sensorList[index].description}",
            3)
    );
  }
}