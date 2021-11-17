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

  final _titles = ['Chats', 'Explore', 'Profile'];

  void selectedIndexOnChanged(int selected) =>
      setState(() => _selectedIndex = selected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: CTypography.title.style,
        ),
        elevation: 0.0,
        backgroundColor: CColor.white.color,
        bottom: PreferredSize(
          child: Container(
            decoration: BoxDecoration(gradient: CColor.gradient.ltr),
            height: 1.2,
          ),
          preferredSize: const Size.fromHeight(1.2),
        ),
      ),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: CColor.gradient.ltr,
          border: Border(
            top: BorderSide(width: 1.2, color: CColor.gradient.color),
          ),
        ),
        child: Container(
          color: CColor.white.color,
          child: SalomonBottomBar(
            currentIndex: _selectedIndex,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Ionicons.chatbubble_outline),
                activeIcon: const Icon(Ionicons.chatbubble),
                selectedColor: CColor.blue.color,
                title: const Text('Chats'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Ionicons.footsteps_outline),
                activeIcon: const Icon(Ionicons.footsteps),
                selectedColor: CColor.darkGreen.color,
                title: const Text('Explore'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Ionicons.person_circle_outline),
                activeIcon: const Icon(Ionicons.person_circle),
                selectedColor: CColor.lightGreen.color,
                title: const Text('Profile'),
              ),
            ],
            onTap: selectedIndexOnChanged,
            unselectedItemColor: CColor.headline.color,
            margin: space(horizontal: 32, vertical: 16),
          ),
        ),
      ),
    );
  }
}
