import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:moim/components/components.dart';

Widget floatingSearchBar() {
  final isPortrait = Get.height > Get.width;

  return FloatingSearchBar(
    hint: 'Search',
    hintStyle: CTypography.callOut.style,

    /// animation
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    debounceDelay: const Duration(milliseconds: 500),
    transition: CircularFloatingSearchBarTransition(),

    /// size
    width: Get.width * 0.9,
    openAxisAlignment: 0.0,
    axisAlignment: isPortrait ? 0.0 : -1.0,
    borderRadius: BorderRadius.circular(30.0),
    border: BorderSide(color: CColor.border.color),
    elevation: 0.0,

    /// events
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Ionicons.search),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      )
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Material(
          color: CColor.white.color,
          elevation: 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
  );
}
