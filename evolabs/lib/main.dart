import 'package:evolabs/screens/analyze.dart';
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/screens/settings.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      const Dashboard(),
      const Analyze(),
      const Settings(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        iconSize: 40,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: secondaryColor,
        title: "Dashboard",
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.line_axis_outlined,
          color: Colors.black,
        ),
        iconSize: 40,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: Colors.white,
        ),
        activeColorPrimary: highlightColor4,
        inactiveColorPrimary: secondaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_outlined),
        iconSize: 40,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: secondaryColor,
        title: "Settings",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarItems(),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 200),
      ),
      decoration: const NavBarDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 17, 17, 17),
            Color.fromARGB(255, 67, 67, 67)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      navBarStyle: NavBarStyle.style15,
      navBarHeight: 90,
    );
  }
}
