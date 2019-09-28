import 'dart:convert';
import 'package:http/http.dart' as http;

class Dialects {
  static final String boston = 'boston';
  static final String cockney = 'cockney';
  static final String groot = 'groot';
  static final String leetspeak = 'leetspeak';
  static final String minion = 'minion';
  static final String numbers = 'numbers';
  static final String oldenglish = 'old english';
  static final String piglatin = 'pig latin';
  static final String pirate = 'pirate';
  static final String shakespeare = 'shakespeare';
  static final String valley = 'valley';
  static final String yoda = 'yoda';

  static List<String> asList() {
    return <String>[
      boston, cockney, groot, leetspeak, minion, numbers,
      oldenglish, piglatin, pirate, shakespeare, valley
    ];
  }
}

class TranslationService {
  static final String url = 'api.funtranslations.com';

  static Future<String> translate(String dialect, String text) async {
    dialect = dialect.replaceAll(' ', '');
    var params = {'text': text};
    var uri = Uri.https(url, '/translate/$dialect.json', params);
    var response = await http.get(uri);
    var responseJson = json.decode(response.body);
    if (response.statusCode != 200) {
      return 'Too many requests; try again later.';
    }
    print(responseJson['contents']['translation']);
    String translation = responseJson['contents']['translation'];
    return translation;
  }
}