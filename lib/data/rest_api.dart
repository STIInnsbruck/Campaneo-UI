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

  static final String kHost = 'management.campaneo.vwn.cloud';
  static final String kBasePath = '/';

  Uri kBaseUrl = new Uri.https(kHost, kBasePath);

  static final String token = 'eyJraWQiOiJEaG5DRnJCZkt2WFRsbEtuYUZKYlF6SSttMU9nMDErWHFZTkhwdjFZNGJnPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI1YzNmYjc4NS1iODE1LTQ2OTMtODcyNC03MTgyMzMxNjA1ZjAiLCJjb2duaXRvOmdyb3VwcyI6WyJPcmdhbml6YXRpb25BZG1pbiIsIk9yZ2FuaXphdGlvbk93bmVyIiwiT3JnYW5pemF0aW9uUHJvamVjdE1hbmFnZXIiXSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tXC9ldS1jZW50cmFsLTFfRVpBMlY0WTVuIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNWJ0dTV1MzZwYXMwNm8yZHN2cmdlajRvc28iLCJldmVudF9pZCI6Ijk0YWQwMzFjLWFjMTQtNDliNS05NmNkLTNlMTNkNzE4ZmM0ZCIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoib3BlbmlkIGVtYWlsIiwiYXV0aF90aW1lIjoxNjQ2OTk1NzQ2LCJleHAiOjE2NDY5OTkzNDYsImlhdCI6MTY0Njk5NTc0NywianRpIjoiYWNhMWY5MGQtMmRkMi00YzcyLTk4MjMtYjlhOTNmYWY1ZDJhIiwidXNlcm5hbWUiOiI1YzNmYjc4NS1iODE1LTQ2OTMtODcyNC03MTgyMzMxNjA1ZjAifQ.v-Lxo4C-XA_mOCgGxpubXVtclRANtxXOGTS3LTdtRUsp2TU1PTKPsSlxoEYuWgPNOYuWIeMdHbE3w_A2HZKJn4hIcF1KkzUBfLFEMqJtEoGXYsustxnKhQH4xPhagvEO8PyNOeM3dMUle9ucv_LdTK9n7msaIf1d_klQBliUXOAI_Wbv_ZnFchOuu402Dnuh20jmI50_jVeeq4hk2tiSvNcxU11_rs3tAiUhcAq-AKGI0LZISNfrJJ14H0JZ_lGFBRAYL-aLPoTDxXz0ypsR5d-rzb2lVDFXktUVxVPmzKafp-25YrSb4snIqUwNH5uNfV_GharBdynvpkwXElvwrw';

  static var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  ResponseParser parser = ResponseParser();

  Future<List<Campaign>> fetchAllCampaigns() async {
    final response = await http.get(kBaseUrl.replace(path: '/campaigns'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return parser.parseAllCampaigns(data);
    } else {
      throw Exception('Failed to load all contract.\nStatus code: ${response.statusCode}');
    }
  }


}
