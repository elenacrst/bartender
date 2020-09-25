import 'package:bartender/data/api/api_client.dart';
import 'package:bartender/data/bartender_repository.dart';
import 'package:bartender/ui/list/drinks_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'blocs/list/drinks_list_cubit.dart';

void main() {
  runApp(BartenderApp());
}

class BartenderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bartender',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.amber,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CubitProvider<DrinksListCubit>(
          create: (context) => DrinksListCubit(
              repository: BartenderRepository(apiClient: ApiClient())),
          child: DrinksListScreen(),
        ));
  }
}
