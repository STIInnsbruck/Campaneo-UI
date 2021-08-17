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
    return widget.currentUser.newCampaigns.isEmpty
        ? Query(
        options: QueryOptions(
          documentNode: gql(CampaignFetch.fetchAll),
        ),
        // ignore: missing_return
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
              ),
            );
          }
          // ignore: missing_return
          List newCampaigns = result.data['getCreatedCampaigns2'];
          for (int i = 0; i < newCampaigns.length; i++) {
            widget.currentUser.newCampaigns.add(Campaign.fromLazyCacheMap(newCampaigns[i]));
          }
          return widget.currentUser.newCampaigns.isNotEmpty
              ? Scrollbar(
            child: GridView.builder(
              itemCount: widget.currentUser.newCampaigns.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.85
              ),
              itemBuilder: (context, int index) =>
                  CampaignTile(context, index, widget.currentUser.newCampaigns[index], widget.currentUser, updateList),
            ),
          )
              : Container();
        }
    ) : Scrollbar(
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

  updateList() {
    setState(() {
      widget.currentUser.newCampaigns = widget.currentUser.newCampaigns;
    });
  }

}
