//How a place should look like

import 'dart:io';

class PlaceLocation{
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
});
}

class PlaceItem{
  final String id;
  final String title;
  final File img;
  final PlaceLocation? location;

  PlaceItem({
    required this.id,
    required this.title,
    required this.img,
    this.location
});
}