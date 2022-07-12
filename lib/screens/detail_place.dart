import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../screens/full_map_screen.dart';

class DetailPlaceScreen extends StatelessWidget {

  static const placeDetailRouteName = '/detail_place';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments.toString();
    final selectedPlace = Provider.of<PlacesProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(selectedPlace.img, fit: BoxFit.cover, width: double.infinity,),
            ),
          ),
          const SizedBox(height: 10,),
          Text(selectedPlace.location!.address.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10,),
          //12_07: Open the full screen map to view the place
          TextButton(onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                    builder: (ctx) => FullMapScreen(
                    isSelect: false,
                    initialLocation: selectedPlace.location!,)
                  ,)
              );
            }, child: Text('Check full map'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
