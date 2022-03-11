import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'response_parser.dart';
import 'models.dart';

//The three REST API endpoints.
const String accessUrl = 'access.campaneo.vwn.cloud';
const String databrokerUrl = 'databroker.campaneo.vwn.cloud';
const String managementUrl = 'management.campaneo.vwn.cloud';

class RestApiClient {
  static final String kBasePath = '/';

  Uri mgmtUrl = new Uri.https(managementUrl, kBasePath);
  Uri acsUrl = new Uri.https(accessUrl, kBasePath);
  Uri brokerUrl = new Uri.https(databrokerUrl, kBasePath);

  static final String token = 'eyJraWQiOiJEaG5DRnJCZkt2WFRsbEtuYUZKYlF6SSttMU9nMDErWHFZTkhwdjFZNGJnPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI1YzNmYjc4NS1iODE1LTQ2OTMtODcyNC03MTgyMzMxNjA1ZjAiLCJjb2duaXRvOmdyb3VwcyI6WyJPcmdhbml6YXRpb25BZG1pbiIsIk9yZ2FuaXphdGlvbk93bmVyIiwiT3JnYW5pemF0aW9uUHJvamVjdE1hbmFnZXIiXSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tXC9ldS1jZW50cmFsLTFfRVpBMlY0WTVuIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNmhiczFyam1rOHI5dW9sZjlpaGpvcW41djUiLCJldmVudF9pZCI6ImY5NTJjOGU5LWI0N2UtNDI5ZS1iYTMyLWMxNWZmOGEyOTgyNCIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoib3BlbmlkIGVtYWlsIiwiYXV0aF90aW1lIjoxNjQ3MDEwNDgzLCJleHAiOjE2NDcwMTQwODMsImlhdCI6MTY0NzAxMDQ4MywianRpIjoiZjkwZjg0YTAtMWQ0My00ZDFlLTg5ZmUtYzRiY2QzZWIxZjA4IiwidXNlcm5hbWUiOiI1YzNmYjc4NS1iODE1LTQ2OTMtODcyNC03MTgyMzMxNjA1ZjAifQ.BtqUMnWJLH7LD3vtrRD1hHH0JQOa0C8pP8OpEeQLzcnnPx_JjIASld1LwyZalhU3VSJi0SQrw_Sz1g1PiKR0FS5rlFREQvJeKgNfZ-ifK4c2bUVl3BVSwTyfbG9i3oW0rX4vhZ-g12Dp9mZiqGQG7QplTJhDQ1sqPBFDbhnGD0xv82zvLuBtgh_u73CwQoChCZsl_bWrDzdixFZpIeRGEpyFjRqmoI84SM29IVU7ue6bbLoje2G1NaXkdcgMhWPdLlmhpqpMY4YEJo00X3DtOPcu5LbdikPJO8lahovJGIsZHtfr-VGo6wNgVd9cXwYCRvlKMQM7EKx_CfrKToCuDw';

  static var headers = {
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  ResponseParser parser = ResponseParser();

  Future<Organization> fetchOrganizationById(String id) async {
    //final response = await http.get(acsUrl.replace(path: '/organizations/$id'), headers: headers);
    print(await http.get('access.campaneo.vwn.cloud/organizations/764851f9-db3c-4641-91e0-c9e8f0faf9bf', headers: headers));
    final responseOrg = await http.get('access.campaneo.vwn.cloud/organizations/764851f9-db3c-4641-91e0-c9e8f0faf9bf', headers: headers);

    if (responseOrg.statusCode == 200) {
      var data = jsonDecode(responseOrg.body);
      return parser.parseOrganization(data);
    } else {
      throw Exception('Failed to load organization with organization id: $id.\nStatus code: ${responseOrg.statusCode}');
    }
  }

  Future<List<Campaign>> fetchAllCampaigns() async {
    final response = await http.get(mgmtUrl.replace(path: '/campaigns'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      //List<Campaign> campaigns = parser.parseAllCampaigns(data);

      /**campaigns.forEach((element) async {
        element.organization = await fetchOrganizationById(element.organizationId);
      });*/
      //print(campaigns[0].name);
      return parser.parseAllCampaigns(data);
    } else {
      throw Exception('Failed to load all contract.\nStatus code: ${response.statusCode}');
    }
  }


}
