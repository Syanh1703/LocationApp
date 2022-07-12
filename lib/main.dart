import 'package:flutter/material.dart';
import './screens/detail_place.dart';
import '../screens/list_of_places_screen.dart';
import 'package:provider/provider.dart';
import './providers/places_provider.dart';
import './screens/add_place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: Colors.amber),
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlacesScreen.addPlaceRouteName: (ctx) => AddPlacesScreen(),
          DetailPlaceScreen.placeDetailRouteName: (ctx) => DetailPlaceScreen(),
        },
      ),
    );
  }
}

