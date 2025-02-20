import 'package:flutter/material.dart';
import 'package:france_itineraire/core/theme.dart';
import 'package:global_bottom_navigation_bar/global_bottom_navigation_bar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:france_itineraire/pages/home.dart';
import 'package:france_itineraire/pages/distance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      home: const KeyboardVisibilityProvider(
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      listOfChild: const [
        Home(),
        Distance(),
      ],
      listOfBottomNavigationItem: buildBottomNavigationItemList(),
    );
  }

  List<BottomNavigationItem> buildBottomNavigationItemList() => [
        BottomNavigationItem(
          activeIcon: const Icon(
            Icons.home_filled,
            color: Colors.blue,
            size: 18,
          ),
          inActiveIcon: const Icon(
            Icons.home,
            color: Colors.grey,
            size: 21,
          ),
          title: "Home",
          color: Colors.white,
          vSync: this,
        ),

        BottomNavigationItem(
          activeIcon: const Icon(
            Icons.maps_home_work,
            color: Colors.blue,
            size: 18,
          ),
          inActiveIcon: const Icon(
            Icons.map,
            color: Colors.grey,
            size: 21,
          ),
          title: 'Maps',
          color: Colors.white,
          vSync: this,
        )
      ];
}
