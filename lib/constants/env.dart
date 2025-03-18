import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  static final String baseUrl = dotenv.env["BASE_URL"] ?? "";
}
