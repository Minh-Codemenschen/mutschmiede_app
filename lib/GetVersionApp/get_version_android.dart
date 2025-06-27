import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getVersionAndroid() async {
  const url = 'https://mutschmiede.com/wp-json/app/v1/api_release_version';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data['success'] == true && data['data'] != null) {
      var appStoreVersion = data['data']['google_play_version'];
      return appStoreVersion;
    } else {
      throw 'No version information found in the response';
    }
  } else {
    throw 'Failed to fetch data from Mutschmiede';
  }
}

Future<String> getVersionAd() async {
  try {
    final String versionString = await getVersionAndroid();
    return versionString;
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}
