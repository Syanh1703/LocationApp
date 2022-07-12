import 'package:flutter/material.dart';
import '../screens/detail_place.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../screens/add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of places'),
        actions: <Widget>[
          IconButton(onPressed: (){
              Navigator.of(context).pushNamed(AddPlacesScreen.addPlaceRouteName);
            }, icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false).fetchAndSetPlaces(),
        builder:(ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? const Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
            builder: (ctx, placesList, child) => placesList.places.isEmpty ? child! : ListView.builder(
                itemBuilder: (ctx,i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(placesList.places[i].img),
                  ),
                  title: Text(placesList.places[i].title),
                  //11_07: Update the address to the screen
                  subtitle: Text(placesList.places[i].location!.address.toString()),
                  onTap: (){
                    //Go the detail page
                    Navigator.of(context).pushNamed(DetailPlaceScreen.placeDetailRouteName, arguments: placesList.places[i].id);
                  },
                ),
              itemCount: placesList.places.length,
            ),
            child: const Center(
              child: Text('No places added yet'),
            ),
        ),
      ),
    );
  }
}
