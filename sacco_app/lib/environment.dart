import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get serverIp => dotenv.env['SERVER_IP']!;
  static String get forgotPasswordUrl => dotenv.env['ForgotPasswordUrl']!;
  static String get mediaUrl => dotenv.env['MEDIA_URL']!;
}
