
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import '../models/place_item.dart';
import '../helper/db_helper.dart';
import '../helper/location_helper.dart';

class PlacesProvider with ChangeNotifier{
  List<PlaceItem> _places = [];
  final String tableName = 'user_places';

  List<PlaceItem> get places{
    return [..._places]; //Can be changed from outside
  }

  //12_07: Method to get the properties of places and move to detail screen
  PlaceItem findById(String id){
    return _places.firstWhere((element) => element.id == id);
  }

  void addPlace(String title, File imgFile, PlaceLocation pickedLocation) async {
    //Adjust the pickedLocation to the human readable
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updatePlace = PlaceLocation(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude, address: address);
    final newPlace = PlaceItem(id: DateTime.now().toString(),
        title: title,
        img: imgFile,
        location: updatePlace
    );
    _places.add(newPlace);
    notifyListeners();
    DatabaseHelper.insert(tableName, {
      'id' : newPlace.id,
      'title': newPlace.title,
      'image': newPlace.img.path,///Store the path, not the image file itself
      //11_07: Update the database
      'loc_lat': newPlace.location!.latitude,
      'loc_long': newPlace.location!.longitude,
      'address': newPlace.location!.address
    });
  }

  Future<void> fetchAndSetPlaces() async{
    final dataList = await DatabaseHelper.getData(tableName);
    _places = dataList.map((item) => PlaceItem(
        id: item['id'],
        title: item['title'],
        img: File(item['image']), //Load the actual file to the memory
        //11_07: Update the method fetch data
        location: PlaceLocation(latitude: item['loc_lat'], longitude: item['loc_long'], address: item['address']),
    )
    ).toList();
    notifyListeners();
  }
}