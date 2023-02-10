import 'package:evolabs/screens/analyze.dart';
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/screens/settings.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

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
        home: FlutterSplashScreen.fadeIn(
          backgroundImage: Image.asset(
            'assets/images/splash-screen-background.jpg',
          ),
          childWidget: Padding(
            padding: const EdgeInsets.only(top: 85, right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 270,
                width: 270,
                child: SvgPicture.asset(
                  'assets/images/name-logo.svg',
                ),
              ),
            ),
          ),
          defaultNextScreen: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
