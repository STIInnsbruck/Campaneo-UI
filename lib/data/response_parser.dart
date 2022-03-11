import 'models.dart';

class ResponseParser {

  Campaign parseCampaign(Map jsonCampaign) {
    return Campaign(
      name: jsonCampaign['profile']['name'],
      description: jsonCampaign['profile']['description'],
      id: jsonCampaign['campaign_id'],
      organizationId: jsonCampaign['organization_id'],
      validFrom: jsonCampaign['processing_options']['start_date'],
      validTo: jsonCampaign['processing_options']['end_date']
    );
  }

  List<Campaign> parseAllCampaigns(List jsonList) {
    return jsonList.map((jsonCampaign) => parseCampaign(jsonCampaign)).toList();
  }

  Organization parseOrganization(Map jsonOrganization) {
    return Organization(
      id: jsonOrganization['id'],
      name: jsonOrganization['name'],
      email: jsonOrganization['contact_email'],
      phone: jsonOrganization['phone_number'],
      address: Address(
        country: jsonOrganization['country'],
        city: jsonOrganization['city'],
        postCode: jsonOrganization['postcode'],
        street: jsonOrganization['street'],
        number: jsonOrganization['street_number']
      )
    );
  }
}