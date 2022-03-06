import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'response_parser.dart';
import 'models.dart';

class RestApiClient {

  static final String kHost = 'management.campaneo.vwn.cloud';
  static final String kBasePath = '/';

  Uri kBaseUrl = new Uri.https(kHost, kBasePath);

  static final String token = '';

  static var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  ResponseParser parser = ResponseParser();

  Future<List<Campaign>> fetchAllCampaigns() async {
    final response = await http.get(kBaseUrl.replace(path: '/campaigns'), headers: headers);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return parser.parseAllCampaigns(data[0]);
    } else {
      throw Exception('Failed to load all contract.\nStatus code: ${response.statusCode}');
    }
  }


}
