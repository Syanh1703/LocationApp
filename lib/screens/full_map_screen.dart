import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place_item.dart';

class FullMapScreen extends StatefulWidget {

  final PlaceLocation initialLocation;
  final bool isSelect;

  FullMapScreen({
    this.initialLocation = const PlaceLocation(latitude: 37.422,longitude: -122.084),
    required this.isSelect});

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {

  //11_07: Store the pick location by user
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Map'),
        actions: <Widget>[
          if(widget.isSelect) IconButton(icon: const Icon(Icons.check),
            onPressed: _pickedLocation == null ? null : (){
                Navigator.of(context).pop(_pickedLocation);//Return the back the picked location to the location input screen
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelect? _selectLocation : null,
        markers: (_pickedLocation==null && widget.isSelect == true)?{}:{
            Marker(
              markerId: MarkerId('m0'),
              position: _pickedLocation ?? LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude)
            ),
        },
      ),
    );
  }
}
