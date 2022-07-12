import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helper/location_helper.dart';
import '../screens/full_map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  //10_07: Get the user coordinate
  String? _previewImgUrl;

  void _showPreviewImageUrl(double lat, double lng){
      final staticMapImgUrl = LocationHelper.generateLocationPreviewImage(
          latitude: lat,
          longitude: lng);
      setState(() {
        _previewImgUrl = staticMapImgUrl;
      });
  }

  Future<void> _getCurrentUserLocation() async {
    try{
      final locationData = await Location().getLocation();//Get the latitude and longitude
      _showPreviewImageUrl(locationData.latitude!, locationData.longitude!);

      //11_07: Trigger up the on select place
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    }catch(error){
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(builder: (ctx) => FullMapScreen(isSelect: true),
          fullscreenDialog: true
        ),
    );
    if(selectedLocation == null){
      return;
    }
    _showPreviewImageUrl(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);

    print('User location longitude: ${selectedLocation.longitude}');
    print('User location latitude: ${selectedLocation.latitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: _previewImgUrl == null ? const Text('No Location chosen',
            textAlign: TextAlign.center,) : Image.network(_previewImgUrl!,
            fit: BoxFit.cover, width: double.infinity,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select On Map'),
            ),
          ],
        )
      ],
    );
  }
}
