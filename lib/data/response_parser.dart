import 'models.dart';

class ResponseParser {

  Campaign parseCampaign(Map jsonCampaign) {
    return Campaign(
      name: jsonCampaign['profile']['name'],
      description: jsonCampaign['profile']['description'],
      id: jsonCampaign['campaign_id'],
      organization: jsonCampaign['organization_id'],
      validFrom: jsonCampaign['time_triggers']['start_time'],
      validTo: jsonCampaign['time_triggers']['end_time']
    );
  }

  List<Campaign> parseAllCampaigns(List jsonList) {
    return jsonList.map((jsonCampaign) => parseCampaign(jsonCampaign)).toList();
  }
}