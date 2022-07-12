import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/models/place_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import '../providers/places_provider.dart';
import '../widgets/location_input.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({Key? key}) : super(key: key);

  static const addPlaceRouteName = '/add_place';
  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File? _pickedImg;
  PlaceLocation? _pickedLocation;

  void _selectImage(File imgFile){
      _pickedImg = imgFile;
  }

  void _selectPlace(double latitude, double longitude){
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }
  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImg == null || _pickedLocation == null){
      //Invalid input
      return;
    }
    Provider.of<PlacesProvider>(context, listen: false).addPlace(_titleController.text, _pickedImg!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                          controller: _titleController,
                        ),
                        const SizedBox(height: 15,),
                        ImageInput(_selectImage),
                        const SizedBox(height: 15,),
                        LocationInput(_selectPlace),
                      ],
                    ),
                  ),
                ),
              ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Theme.of(context).primaryColor,
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
            ),
          ],
        ),
      ),
    );
  }
}
