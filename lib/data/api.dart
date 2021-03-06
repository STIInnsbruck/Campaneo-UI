import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// TODO handle this with config file
const String URI_PROD = 'http://graphql.campaneo.vwn.cloud/graphql';
const String URI_INT = 'https://campaneo.herokuapp.com/graphql';
const String URI_DEV = 'http://localhost:9002/graphql';

class ApiClient {
  static final HttpLink httpLink = HttpLink(uri: URI_INT);

  static ValueNotifier<GraphQLClient> initClient() => ValueNotifier(
    GraphQLClient(
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
      link: httpLink,
    ),
  );
}
