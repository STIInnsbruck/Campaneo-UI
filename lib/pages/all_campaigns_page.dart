import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campaneo_app/widgets/campaign_tile.dart';

class AllCampaignsPage extends StatelessWidget {
  static const String routeName = '/allcampaigns';
  static const String pageTitle = 'AllCampaigns';

  //TODO: replace hardcoded tiles with actual tiles
  @override
  Widget build(BuildContext context) {

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Scrollbar(
          child: GridView.builder(
            itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.85
              ),
              itemBuilder: (BuildContext context, int index) => CampaignTile('Item $index')
          ),
        ),
    );
  }
}
