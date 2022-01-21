import 'package:campaneo_app/data/models.dart';
import 'package:campaneo_app/data/campaign_fetch.dart';
import 'package:campaneo_app/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:campaneo_app/data/user.dart';

import 'package:campaneo_app/widgets/campaign_info_dialog.dart';

import 'campaign_info_dialog.dart';

class QueryableCampaignDetails extends StatelessWidget {
  final String id;
  List<User> userList;
  List newCampaignsList;
  User currentUser;
  int index;
  BuildContext context;
  Function statusCallback;

  QueryableCampaignDetails(this.context, this.index, this.newCampaignsList, this.currentUser, this.statusCallback, {@required this.id});

  @override
  Widget build(context) {
    return CampaignInfoDialog(
        currentUser.newCampaigns[index], context, currentUser, newCampaignsList, index, statusCallback
    );
  }
}
