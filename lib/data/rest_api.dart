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

  static final String token = 'eyJraWQiOiJEaG5DRnJCZkt2WFRsbEtuYUZKYlF6SSttMU9nMDErWHFZTkhwdjFZNGJnPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI1YzNmYjc4NS1iODE1LTQ2OTMtODcyNC03MTgyMzMxNjA1ZjAiLCJjb2duaXRvOmdyb3VwcyI6WyJPcmdhbml6YXRpb25BZG1pbiIsIk9yZ2FuaXphdGlvbk93bmVyIiwiT3JnYW5pemF0aW9uUHJvamVjdE1hbmFnZXIiXSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tXC9ldS1jZW50cmFsLTFfRVpBMlY0WTVuIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNmhiczFyam1rOHI5dW9sZjlpaGpvcW41djUiLCJldmVudF9pZCI6IjhmODNkYTk3LTIzOWEtNDZjMy1hN2EzLWIxZjcwYzcyZjRkNyIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoib3BlbmlkIGVtYWlsIiwiYXV0aF90aW1lIjoxNjQ3MTEyNDUyLCJleHAiOjE2NDcxMTYwNTIsImlhdCI6MTY0NzExMjQ1MiwianRpIjoiMDU3NDUyNWUtMjJiZS00MTExLTk1NGMtZWRiMWViMDQ1MTM2IiwidXNlcm5hbWUiOiI1YzNmYjc4NS1iODE1LTQ2OTMtODcyNC03MTgyMzMxNjA1ZjAifQ.d6blFCa2vWhDbd1gM_bYwmb86npWo8Oj4YrsRfGcPawxK3VeAWD1uyB-4qPstBZigxALHLztVd29i2zD7qx7SLqyfQTMAWx2HTzf3EFyQt68OETkPyeELnwXcJOwWklU2Hk0gX3ndtZbesdtowJc3_hFUHZIjEWU4ehjhhHK9zj-2sIRWIdIcqhS8dw_mCdV-sZgaQK-DyPecJvkYE2KN8NdnsuOly-1GXr2dxVJ2q39p-1Yqp8UHqMKNiDmJMqJeFK5iY_Gp8mVv42BUeWLBDYOUX9WSqz6RLbgoRAMkEFVOAxaaVZZNMzoV5EjWJuljOgaiMXVe_aCojS0hFg-8A';

  static var headers = {
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  ResponseParser parser = ResponseParser();

  Future<Organization> fetchOrganizationById(String id) async {
    //TODO: this ID is currently hardcoded in the URL. Use the parameter ASAP.
    final response = await http.get(acsUrl.replace(path: '/organizations/764851f9-db3c-4641-91e0-c9e8f0faf9bf'), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return parser.parseOrganization(data);
    } else {
      throw Exception('Failed to load organization with organization id: $id.\nStatus code: ${response.statusCode}\nResponse: ${response.body}');
    }
  }

  Future<List<Campaign>> fetchAllCampaigns() async {
    final response = await http.get(mgmtUrl.replace(path: '/campaigns'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return parser.parseAllCampaigns(data);
    } else {
      throw Exception('Failed to load all contract.\nStatus code: ${response.statusCode}');
    }
  }

}
