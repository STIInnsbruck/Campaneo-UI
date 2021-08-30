import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/// This widget acts as a tile button for the homepage screen. Where other
/// widgets can be displayed in.


class MenuTile extends StatelessWidget {

  final String title;
  final Widget widget;
  final Function onTap;

  MenuTile(this.title, this.widget, this.onTap);

  //TODO: add ontap-function, all tiles have a different screen to navigate to

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallestScreenSize = setSizingDependency(height, width);

    return Container(
      height: height * 0.45,
      width: width / 2,
      child: Ink(
        decoration: BoxDecoration(
          color: HexColor("#3C3C3C"),
          border: Border.all(color: HexColor("#C4C4C4"), width: 2),
        ),
        child: InkWell(
          child: Column(
            children: <Widget>[
              Text(this.title, style: TextStyle(color: Colors.white, fontSize: smallestScreenSize / 12), textAlign: TextAlign.center),
              Spacer(flex: 2),
              this.widget,
              Spacer(flex: 4),
            ],
          ),
          onTap: () => { this.onTap() },
        ),
      ),
    );
  }

  /// Method to take return the smaller value between height and with.
  /// This value is then used to scale the texts and other widgets, incase
  /// the user changes the window size of the application.
  double setSizingDependency(double height, double width) {
    if(height <= width) {
      return height;
    } else {
      return width;
    }
  }

}