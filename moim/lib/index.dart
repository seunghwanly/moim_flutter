import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moim/components/components.dart';
import 'package:moim/explore/explore.dart';
import 'package:moim/explore/profile/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'chats/chat.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  var _selectedIndex = 0;

  void selectedIndexOnChanged(int selected) =>
      setState(() => _selectedIndex = selected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            const ChatScreen(),
            const ExploreScreen(),
            const ProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Ionicons.chatbubble_outline),
            activeIcon: const Icon(Ionicons.chatbubble),
            selectedColor: CColor.blue.color,
            title: Text(
              'Chats',
              style: CTypography.subHead.style,
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Ionicons.footsteps_outline),
            activeIcon: const Icon(Ionicons.footsteps),
            selectedColor: CColor.darkGreen.color,
            title: Text(
              'Explore',
              style: CTypography.subHead.style,
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Ionicons.person_circle_outline),
            activeIcon: const Icon(Ionicons.person_circle),
            selectedColor: CColor.lightGreen.color,
            title: Text(
              'Profile',
              style: CTypography.subHead.style,
            ),
          ),
        ],
        onTap: selectedIndexOnChanged,
        unselectedItemColor: CColor.headline.color,
      ),
    );
  }
}
