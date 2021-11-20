import 'dart:developer' as dg;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moim/components/components.dart';

class PlacedChattingRoomScreen extends StatefulWidget {
  const PlacedChattingRoomScreen({Key? key}) : super(key: key);

  @override
  PlacedChattingRoomScreenState createState() =>
      PlacedChattingRoomScreenState();
}

class PlacedChattingRoomScreenState extends State<PlacedChattingRoomScreen> {
  late List<List<double>> result;

  @override
  void initState() {
    super.initState();
    setState(() {
      result = getPosition(
          midWidth: Get.width / 2,
          midHeight: Get.height / 2,
          maxWidth: Get.width,
          maxHeight: Get.height,
          data: sampleData);
    });
  }

  @override
  Widget build(BuildContext context) {
    dg.log('maxWidth: ${Get.width} maxHeight: ${Get.height}');
    return InteractiveViewer(
      minScale: 0.1,
      child: Stack(
        children: [
          Stack(
            children: result
                .map(
                  (item) => Positioned(
                      child: CircleAvatar(
                        backgroundColor: CColor.lightGreen.color,
                        radius: item[2],
                        child: Text(item[2].toString()),
                      ),
                      top: item[1],
                      left: item[0]),
                )
                .toList(),
          ),

          /// self
          Align(
              alignment: Alignment.center,
              child: chatComponent(isNewChatArrived: true)),
        ],
      ),
    );
  }
}

/// list[0] -> top, list[1] -> left
List<List<double>> getPosition({
  required double midWidth,
  required double midHeight,
  required double maxWidth,
  required double maxHeight,
  required List<Map<String, dynamic>> data,
}) {
  /// methods for only this method, used for verification
  // bool isInside(y, x) => (0 <= y && y <= maxHeight && 0 <= x && x <= maxWidth);
  bool isInsideWithinDistance(int dist) => dist <= max(midWidth, midHeight);

  bool hasCollided(int r1, int r2, double d) =>
      !(r1 + r1 < d) ||
      ((max(r1, r2) - min(r1, r2) < d) && (d < r1 + r2)) ||
      (max(r1, r2) - min(r1, r2) == d) ||
      (max(r1, r2) - min(r1, r2) > d);

  /// 1) sort by distances
  data.sort((a, b) => DateTime.fromMillisecondsSinceEpoch(b['ts'])
          .isBefore(DateTime.fromMillisecondsSinceEpoch(a['ts']))
      ? 1
      : 0);
  // ListQueue<Map<String, dynamic>> dataQue =
  //     ListQueue.from(data); // convert into Queue
  List<Map<String, dynamic>> dataQue = data;

  /// 2) place the closest chat room first and try 10-times, if it cost over ten-times look for more far distance
  List<List<double>> placed = []; // [[top(y), left(x), radius(r)], ... ]
  // while (dataQue.isNotEmpty) {
  for (int i = 0; i < dataQue.length; ++i) {
    bool hasPlaced = false;
    // Map<String, dynamic> item = dataQue.removeFirst();
    Map<String, dynamic> item = dataQue[i];
    int hasTried = 0;
    int dist = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(item['ts']))
        .inHours;

    /// check if distance is in range
    if (!isInsideWithinDistance(dist)) continue;
    while (hasTried < 100) {
      int radian = Random().nextInt(360); // search for 360 degree

      /// set new circle to be placed
      double newX = midWidth + dist * cos(radian);
      double newY = midHeight + dist * sin(radian);

      /// set standard distances
      double distFromCenter =
          sqrt(pow(newX - midWidth, 2) + pow(newY - midHeight, 2));

      /// check if collides with center circle
      if (hasCollided(item['pp'], 40, distFromCenter)) {
        // has collided with center circle, reset the radian
        hasTried += 1;
        continue;
      } else {
        bool hasCollidedWithOthers = false;

        /// check if it has collides with the placed circles
        for (var pc in placed) {
          double distFromPlacedCircle =
              sqrt(pow(pc[0] - newX, 2) + pow(pc[1] - newY, 2));

          if (hasCollided(pc[2].toInt(), item['pp'], distFromPlacedCircle)) {
            // has collided with placed circle, need to reset
            hasCollidedWithOthers = true;
            break;
          }
        }

        if (!hasCollidedWithOthers) {
          /// has not collided, save it
          placed.add([newX, newY, item['pp'].toDouble()]);
          hasPlaced = true;
          break;
        }

        /// if the circle has collided with other cirlce
        /// try other radian
        hasTried += 1;
      } // while, hasTried
    }

    if (!hasPlaced) {
      /// if it has not been placed yet, make distance more long
      // item['ts'] -= 86400; // add 1 day : 24 * 3600
      // item['ts'] -= 43200; // add 1/2 day : 12 * 3600
      item['ts'] -= 21600; // add 1/4 day : 6 * 3600
      // dataQue.addFirst(item);
      i -= 1;
    }
  }

  dg.log(placed.toString());
  return placed;
}

Widget chatComponent({required bool isNewChatArrived}) {
  return Container(
    decoration: !isNewChatArrived
        ? BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  color: CColor.text.color.withOpacity(0.25),
                  spreadRadius: 2)
            ],
          )
        : BoxDecoration(
            shape: BoxShape.circle,
            gradient: CColor.gradient.ttb,
          ),
    padding: !isNewChatArrived ? null : space(horizontal: 6.0, vertical: 6.0),
    child: Container(
      padding: !isNewChatArrived ? null : space(horizontal: 4.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: CColor.white.color,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: CColor.blue.color,
      ),
    ),
  );
}

final sampleData = [
  {
    'name': 'G',
    'ts': DateTime.now().millisecondsSinceEpoch - 90061999,
    'pp': 23
  },
  {
    'name': 'A',
    'ts': DateTime.now().millisecondsSinceEpoch - 99126199,
    'pp': 45
  },
  {
    'name': 'Y',
    'ts': DateTime.now().millisecondsSinceEpoch - 123098482,
    'pp': 14
  },
  {
    'name': 'B',
    'ts': DateTime.now().millisecondsSinceEpoch - 12378793,
    'pp': 9
  },
  {
    'name': 'H',
    'ts': DateTime.now().millisecondsSinceEpoch - 41237893,
    'pp': 51
  },
];
