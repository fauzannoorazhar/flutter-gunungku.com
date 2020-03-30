
//Check assets/config.json
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