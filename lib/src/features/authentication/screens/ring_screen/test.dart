import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'filtered_location.dart';

class position {
  final String name;
  final String imgurl;
  final double distance;
  List<Offset> secondPoint = [];
  position({
    required this.name,
    required this.imgurl,
    required this.distance,
    required this.secondPoint,
  });
}

class PositionDifference1 extends StatefulWidget {
  final double cSizeX;
  final double cSizeY;

  PositionDifference1({required this.cSizeX, required this.cSizeY});

  @override
  State<PositionDifference1> createState() => _PositionDifference1State(
        containerSizeX: this.cSizeX,
        containerSizeY: this.cSizeY,
      );
}

class _PositionDifference1State extends State<PositionDifference1> {
  final double x1 = 27.67183690973489;
  final double y1 = 85.42903234436557;
  final double containerSizeX;
  final double containerSizeY;
  Offset? middlePoint;
  List<Offset> secondPoint = [];
  static List<position> positions = [];
  //static List<position> positions1 = [];

  List<position> positionList = [];

  _PositionDifference1State({
    required this.containerSizeX,
    required this.containerSizeY,
  });

  @override
  void initState() {
    double containermidX;
    double containermidY;
    super.initState();
    setlocation();
    containermidX = containerSizeX / 2;
    containermidY = containerSizeY / 2;
    middlePoint = Offset(containermidX, containermidY);
  }

  void setlocation() async {
    LocationScreen location = LocationScreen();
    await location.fetchLocationsFromAPI();
    List<FilteredLocation> loca = location.returnfilteredLocations();
    setState(() {
      positions = makeSecondPointList(loca);
    });
  }

  List<position> makeSecondPointList(List<FilteredLocation> locations) {
    int count1 = 1;
    int count2 = 1;
    int count3 = 1;
    int count4 = 1;
    final double lineSlope1 = 1;
    final double lineSlope2 = 1 / math.sqrt(3);
    final double lineSlope3 = math.sqrt(3);
    final double lineSlope4 = 1;

    for (final item in locations) {
      double diffX = item.latitude - x1;
      double diffY = item.longitude - y1;
      if (diffX >= 0 && diffY >= 0) {
        if (count1 == 1)
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope1,
            item.name,
            item.imgurl,
          );
        else if (count1 == 2)
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope2,
            item.name,
            item.imgurl,
          );
        else if (count1 == 3)
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope3,
            item.name,
            item.imgurl,
          );
        else
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope4,
            item.name,
            item.imgurl,
          );
        count1++;
      } else if (diffX >= 0 && diffY < 0) {
        if (count2 == 1)
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope1,
            item.name,
            item.imgurl,
          );
        else if (count2 == 2)
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope2,
            item.name,
            item.imgurl,
          );
        else if (count2 == 3)
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope3,
            item.name,
            item.imgurl,
          );
        else
          calculateSecondPoint(
            1,
            item.distance,
            lineSlope4,
            item.name,
            item.imgurl,
          );
        count2++;
      } else if (diffX < 0 && diffY >= 0) {
        if (count3 == 1)
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope1,
            item.name,
            item.imgurl,
          );
        else if (count3 == 2)
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope2,
            item.name,
            item.imgurl,
          );
        else if (count3 == 3)
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope3,
            item.name,
            item.imgurl,
          );
        else
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope4,
            item.name,
            item.imgurl,
          );
        count3++;
      } else {
        if (count4 == 1)
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope1,
            item.name,
            item.imgurl,
          );
        else if (count4 == 2)
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope1,
            item.name,
            item.imgurl,
          );
        else if (count4 == 3)
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope1,
            item.name,
            item.imgurl,
          );
        else
          calculateSecondPoint(
            2,
            item.distance,
            lineSlope1,
            item.name,
            item.imgurl,
          );
        count4++;
      }
    }

    return positionList;
  }

  void calculateSecondPoint(
    int screen,
    double distance,
    double lineSlope,
    String name1,
    String imgurl1,
  ) {
    double angle = math.atan(lineSlope);
    double deltaX = (distance) * math.cos(angle);
    double deltaY = (distance) * math.sin(angle);
    double x = middlePoint!.dx + (screen == 1 ? deltaX : -deltaX);
    double y = middlePoint!.dy + (screen == 1 ? deltaY : -deltaY);
    Offset point = Offset(x, y);

    setState(() {
      positionList.add(
        position(
          name: name1,
          imgurl: imgurl1,
          distance: distance,
          secondPoint: [point],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: middlePoint!.dx - 135,
          top: middlePoint!.dy - 16,
          child: CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(
                'assets/images/user.png'), // Replace with your image path
          ),
        ),
        ...positions
            .asMap()
            .entries
            .map(
              (entry) => Positioned(
                left: entry.value.secondPoint[0].dx - 119,
                top: entry.value.secondPoint[0].dy - 100,
                child: InkWell(
                  onTap: () {
                    Container(
                      width: 120,
                      height: 120,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(169, 152, 157, 157),
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      positions[entry.key].imgurl,
                                    ), // Replace with the actual path to your image
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          positions[entry.key].name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                width: 80,
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: Color.fromARGB(236, 5, 90, 136),
                                    ),
                                    Text(
                                      '${positions[entry.key].distance.toStringAsFixed(2)}m',
                                      style: TextStyle(
                                        color: Color.fromARGB(236, 5, 90, 136),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 90,
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: 85,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(169, 152, 157, 157),
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    positions[entry.key].imgurl,
                                  ), // Replace with the actual path to your image
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        positions[entry.key].name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: 80,
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 12,
                                    color: Color.fromARGB(236, 5, 90, 136),
                                  ),
                                  Text(
                                    '${positions[entry.key].distance.toStringAsFixed(2)}m',
                                    style: TextStyle(
                                      color: Color.fromARGB(236, 5, 90, 136),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
