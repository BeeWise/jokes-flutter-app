import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndpointsBuilder {
  EndpointsBuilder._privateConstructor();
  static final EndpointsBuilder instance =
      EndpointsBuilder._privateConstructor();

  String jokesEndpoint() {
    return dotenv.get("JOKES_ENDPOINT");
  }
}
