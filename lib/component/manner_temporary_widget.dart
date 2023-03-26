import 'package:flutter/material.dart';

class MannerTemperature extends StatelessWidget {
  double manorTemp;
  int level;

  final List<Color> tempPerColors = [
    const Color(0xff072038),
    Color(0xff0d3a65),
    Color(0xff186ec0),
    Color(0xff37b24d),
    Color(0xffffad13),
    Color(0xfff76707),
  ];

  MannerTemperature({required this.manorTemp, required this.level, Key? key}) {
    _calcTempLevel();
  }

  void _calcTempLevel() {
    if (20 >= manorTemp) {
      level = 0;
    } else if (20 < manorTemp && 32 >= manorTemp) {
      level = 1;
    } else if (32 < manorTemp && 36.5 >= manorTemp) {
      level = 2;
    } else if (36.5 < manorTemp && 40 >= manorTemp) {
      level = 3;
    } else if (40 < manorTemp && 50 >= manorTemp) {
      level = 4;
    } else if (50 < manorTemp) {
      level = 5;
    }
  }

  Widget _makeTempLabelBar() {
    return Container(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${manorTemp}C',
            style: TextStyle(
                color: tempPerColors[level],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 6.0,
              color: Colors.black.withOpacity(0.2),
              child: Row(
                children: [
                  Container(
                    height: 6,
                    width: 60 / 99 * manorTemp,
                    color: tempPerColors[level],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _makeTempLabelBar(),
              Container(
                margin: EdgeInsets.only(
                  left: 7,
                ),
                width: 30,
                height: 30,
                child: Image.asset('assets/images/level-${level}.jpg'),
              ),
            ],
          ),
          Text(
            '매너온도',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
