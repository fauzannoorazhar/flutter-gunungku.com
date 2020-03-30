
//Check assets/config.json
import 'package:shared_preferences/shared_preferences.dart';

class Config
{
    final String apiUrl;

    Config({
        this.apiUrl
    });

    factory Config.fromJson(Map<String, dynamic> parsedJson) {
        return Config(
            apiUrl: parsedJson['apiUrl']
        );
    }
}