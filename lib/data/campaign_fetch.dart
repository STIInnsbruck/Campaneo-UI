class CampaignFetch {
  static final String fetchAll = """
    query { 
      getCreatedCampaigns2 {
        id
        name
      } 
    }
  """;

  static final String fetchById = """
{
      getCampaign2 (campaign_id: \$id) {
        __typename
        id
        description
        image_url
        name
        valid_from
        valid_to
        organization {
          id
          name
          country
          city
          contact_email
          phone_number
          street
          street_number
        }
      }
    }
  """;
}
