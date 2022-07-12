import 'package:http/http.dart' as http;
import 'dart:convert';
const GOOGLE_API_KEY = 'AIzaSyALLc5aWyxbz3YThhHebf3POmbz6KndHcs';

class LocationHelper{
  static String generateLocationPreviewImage({required double latitude, required double longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async {
    ///11_07: Send HTTP requests to Google server
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY');
    //Send the GET request
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];//Return readble address
  }
}