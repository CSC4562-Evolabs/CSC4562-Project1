import 'package:evolabs/utils/colors.dart';
import 'package:evolabs/utils/permissions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool darkModeSwitch = true;
  bool notificationsSwitch = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Scaffold(
          backgroundColor: backgroundColor2,
          body: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
            child: Column(
              children: [
                // DARK MODE SETTING
                Padding(
                  padding: const EdgeInsets.only(top: 11.5, bottom: 11.5),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.moon,
                        color: highlightColor2,
                        size: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Dark Mode",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        activeColor: highlightColor2,
                        value: darkModeSwitch,
                        onChanged: (bool value) {
                          setState(() {
                            darkModeSwitch = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // NOTIFICATIONS SETTING
                Padding(
                  padding: const EdgeInsets.only(top: 11.5, bottom: 11.5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        color: highlightColor2,
                        size: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        activeColor: highlightColor2,
                        value: notificationsSwitch,
                        onChanged: (bool value) {
                          setState(() {
                            notificationsSwitch = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // PERMISSIONS SETTING
                Padding(
                  padding: const EdgeInsets.only(top: 11.5, bottom: 11.5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: highlightColor2,
                        size: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Permissions",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Permissions();
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: highlightColor2,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
                // TEXT SIZE SETTING
                Padding(
                  padding: const EdgeInsets.only(top: 11.5),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.book,
                        color: highlightColor2,
                        size: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Text Size",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: highlightColor2,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 120,
            backgroundColor: backgroundColor2,
            title: const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 78.0,
                  bottom: 15,
                ),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SvgPicture.asset('assets/images/green-circle1.svg'),
      ],
    );
  }
}
