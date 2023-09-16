import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_projecct/Utils/Suggestion.dart';

class PlaceApiProvider {
  PlaceApiProvider();
  static final sessionToken="12345";
  static final String androidKey = 'AIzaSyDBLCF-IWFb1aNXDWpDYl8IufUHBROgbdc';
  static final String iosKey = 'AIzaSyDBLCF-IWFb1aNXDWpDYl8IufUHBROgbdc';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

 static Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$androidKey&sessiontoken=$sessionToken';
    print("place api url"+request.toString());

    final response = await http.get(Uri.parse(request));
    print("response place api"+request.toString());
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print("resupt"+result.toString());
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}