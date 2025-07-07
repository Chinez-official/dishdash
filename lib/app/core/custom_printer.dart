import 'package:logger/logger.dart' as l;

final logger = l.Logger(
  printer: l.PrettyPrinter(
    colors: false,
    methodCount: 0,
    levelEmojis: {
      l.Level.debug: '\u{1F680}', // 🚀
      l.Level.info: '\u{1F7E1}', // 🟡
      l.Level.warning: '\u{1F7E0}', // 🟠
      l.Level.error: '\u{1F977}', // 🥷
      l.Level.fatal: '\u{1F4A5}', // 💥
    },
  ),
);

void debug(String message) => logger.d(message);

void info(String message) => logger.i(message);

void warning(String message) => logger.w(message);

void error(String message) => logger.e(message);

void fatal(String message) => logger.log(l.Level.fatal, message);
