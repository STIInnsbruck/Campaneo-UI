import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:campaneo_app/widgets/information_tile.dart';
import 'package:campaneo_app/data/user.dart';
import 'package:campaneo_app/widgets/status_widget.dart';
import 'package:campaneo_app/data/models.dart';

/// This widget acts as a tile button for the homepage screen. Where other
/// widgets can be displayed in.
class InformationSelectionDialog extends StatefulWidget {

  //TODO: add ontap-function, all tiles have a different screen to navigate to
  User currentUser;
  Function statusCallback;
  int campaignListIndex;
  Campaign campaignDetails;

  InformationSelectionDialog(this.currentUser, this.statusCallback, this.campaignListIndex, this.campaignDetails);

  @override
  _InformationSelectionDialogState createState() => _InformationSelectionDialogState();
}

class _InformationSelectionDialogState extends State<InformationSelectionDialog> {
  List<IconData> iconList = new List();

  int combinedPoints = 0;

  Color confirmButtonColor = Colors.grey;

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    iconList.add(Icons.speed);
    iconList.add(Icons.build);
    iconList.add(Icons.local_gas_station);
    iconList.add(Icons.alarm);
    iconList.add(Icons.location_on);

    return Dialog(
      shape: BeveledRectangleBorder(),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.85;
    double width = MediaQuery.of(context).size.width * 0.80;
    context = context;

    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        color: HexColor("#3C3C3C"),
      ),
      child: Stack(
        children: [
          Scrollbar(
            child: GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0
                ),
                itemBuilder: (BuildContext context, int index) => InformationTile(iconList[index], incrementPoints, widget.currentUser, this.widget.campaignListIndex, index, widget.campaignDetails)
            ),
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: backButton(context, height, width)
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: isActiveCampaign()? infoBox(context, height, width) : acceptButton(context, height, width),
          )
        ],
      ),
    );
  }

  incrementPoints(value) {
    combinedPoints += value;
    setState(() {
      if(combinedPoints > 0) {
        confirmButtonColor = Colors.green;
      } else {
        confirmButtonColor = Colors.grey;
      }
    });
  }



  Widget acceptButton(BuildContext context, double height, double width) {
    return Container(
      height: height * 0.15,
      width: width * 0.25,
      child: Material(
        color: confirmButtonColor,
        child: InkWell(
          child: Center(
            child: Text("CONFIRM SELECTION", style: TextStyle(fontSize: height / 22), textAlign: TextAlign.center),
          ),
          onTap: () {
            if(this.combinedPoints > 0) {
              widget.currentUser.setCompletedCampaigns(widget.currentUser.getCompletedCampaigns+1);
              widget.currentUser.setPoints(widget.currentUser.getPoints + this.combinedPoints);
              widget.statusCallback(Status.Accepted);
              widget.currentUser.acceptedCampaigns.add(widget.currentUser.newCampaigns[widget.campaignListIndex]);
              widget.currentUser.newCampaigns.removeAt(widget.campaignListIndex);
              widget.campaignDetails.status = Status.Accepted;
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }

          },
        ),
      ),
    );
  }

  Widget backButton(BuildContext context, double height, double width) {
    return Container(
      height: height * 0.15,
      width: width * 0.25,
      child: Material(
        color: Colors.grey,
        child: InkWell(
          child: Center(
            child: Text("GO BACK", style: TextStyle(fontSize: height / 22)),
          ),
          onTap: () {
            combinedPoints = 0;
            widget.campaignDetails.sensorList.forEach((element) {element.selected = false;});
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget infoBox(BuildContext context, double height, double width) {
    return Container(
        height: height * 0.15,
        width: width * 0.25,
        child: Material(
          color: Colors.green,
          child: Center(
            child: Text("SHARED INFORMATION", style: TextStyle(fontSize: height / 20)),
          ),
        )
    );
  }

  bool isActiveCampaign() {
    if(widget.campaignDetails.status == Status.Accepted) {
      return true;
    } else {
      return false;
    }
  }
}