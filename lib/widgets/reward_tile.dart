import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:campaneo_app/data/coupon.dart';
import 'package:campaneo_app/data/user.dart';

/// This widget acts as a tile button for the homepage screen. Where other
/// widgets can be displayed in.

class RewardTile extends StatelessWidget {

  final int points;
  final int reductionPercentage;
  final Coupon coupon = new Coupon("Lorem ipsum...");
  List<User> userList;
  String couponTypeName;
  Function callback;
  User currentUser;

  RewardTile(this.points, this.reductionPercentage, this.userList, this.callback, this.currentUser);

  //TODO: add ontap-function, all tiles have a different screen to navigate to

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Ink(
        decoration: BoxDecoration(
          color: HexColor("#3C3C3C"),
          border: Border.all(color: HexColor("#C4C4C4"), width: 1),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("-${this.coupon.getReduction}%", style: TextStyle(color: Colors.white, fontSize: height / 7)),
                    Icon(iconForCouponType(this.coupon.getType), size: height / 7)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Text("${this.coupon.getCost} PTS", style: TextStyle(color: Colors.white, fontSize: height / 15)),
                ),
              ),
            ],
          ),
          onTap: () { hasSufficientPoints()? showPurchaseDialog(context, this.coupon.getCost) : showInsufficientPointsDialog(context); },
        ),
      ),
    );
  }

  bool hasSufficientPoints() {
    if (currentUser.getPoints >= coupon.getCost) {
      return true;
    } else {
      return false;
    }
  }

  showInsufficientPointsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Sorry :("),
        content: Text("You currently do not have enough points to purchase this coupon."),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Dismiss")
          )
        ],
      ),
    );
  }

  showPurchaseDialog(BuildContext context, int points) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Text("Confirm Your Purchase"),
            content: Text("Are you sure you want to purchase the $couponTypeName for $points points?"),
            actions: <Widget>[
              FlatButton(onPressed: () {
                //userList[2].setPointsVoid(userList[2].getPoints - points);
                callback();
                this.currentUser.setPoints(this.currentUser.getPoints - this.coupon.getCost);
                print("new points should be: ${this.currentUser.getPoints}");
                Navigator.of(context).pop();
              },
                  child: Text("Confirm")
              ),
              FlatButton(onPressed: () {
                Navigator.of(context).pop();
              },
                  child: Text("Cancel")
              )
            ]
        )
    );
  }

  IconData iconForCouponType(couponType type) {
    switch(type) {
      case couponType.Fuel:
        couponTypeName = "Reduced-Fuel-Price-Coupon";
        return Icons.local_gas_station;
        break;
      case couponType.CarWash:
        couponTypeName = "Reduced-Car-Wash-Price-Coupon";
        return Icons.local_car_wash;
        break;
      case couponType.Service:
        couponTypeName = "Car-Service-Coupon";
        return Icons.build;
        break;
      default:
        couponTypeName = "Giftcard-Coupon";
        return Icons.card_giftcard;
        break;
    }
  }
}