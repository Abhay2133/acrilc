import 'package:logger/logger.dart';

class LogService {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to display
      errorMethodCount: 8, // Number of method calls if error
      lineLength: 120, // Line length
      colors: true, // Enable color
      printEmojis: true, // Print emojis for log levels
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // Print timestamp
    ),
  );

  static void debug(String message) {
    logger.d(message);
  }

  static void info(String message) {
    logger.i(message);
  }

  static void warning(String message) {
    logger.w(message);
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    logger.e(message);
  }
}
