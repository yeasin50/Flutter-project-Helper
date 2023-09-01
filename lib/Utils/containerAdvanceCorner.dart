import 'package:flutter/material.dart';
import 'dart:math' as math;

class COntainerStyle extends StatefulWidget {
  @override
  _COntainerStyleState createState() => _COntainerStyleState();
}

class _COntainerStyleState extends State<COntainerStyle> {
  double sliderValTX = 0.0;
  double sliderValTY = 0.0;
  double sliderValBX = 0.0;
  double sliderValBY = 0.0;

  @override
  Widget build(BuildContext context) {
    final boxWidth = 300.0;
    final boxHeight = 200.0;
    return Scaffold(
      body: Column(
        children: [
          Slider(
            value: sliderValTX,
            min: 0,
            max: 1,
            onChanged: (val) {
              setState(() {
                sliderValTX = val;
              });

              print("TX ${sliderValTX.toStringAsFixed(2)}");
            },
          ),
          Slider(
            value: sliderValTY,
            min: 0,
            max: 1,
            onChanged: (val) {
              setState(() {
                sliderValTY = val;
              });

              print("TY ${sliderValTY.toStringAsFixed(2)}");
            },
          ),
          Text("RBottom"),
          Slider(
            value: sliderValBX,
            min: 0,
            max: 1,
            onChanged: (val) {
              setState(() {
                sliderValBX = val;
              });

              print("BX ${sliderValBX.toStringAsFixed(2)}");
            },
          ),
          Slider(
            value: sliderValBY,
            min: 0,
            max: 1,
            onChanged: (val) {
              setState(() {
                sliderValBY = val;
              });

              print("BY ${sliderValBY.toStringAsFixed(2)}");
            },
          ),
          Container(
            width: boxWidth,
            height: boxHeight,

            ///* second color
            color: Colors.blue.shade300,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  left: -boxWidth * .7,
                  child: Transform.rotate(
                    angle: .7,
                    child: Container(
                      ///* 2nd color of border
                      color: Colors.orange.shade800,
                      height: boxHeight * 1.2,
                      width: boxWidth * 1.5,
                    ),
                  ),
                ),

                //main view
                Center(
                  child: Container(
                    width: boxWidth * .9,
                    height: boxHeight * .9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          12,
                        ),
                        bottomLeft: Radius.circular(
                          12,
                        ),
                        topRight: Radius.elliptical(
                          ///your x= .15 y: .82
                          boxWidth * .15,
                          boxHeight * .82,
                          // boxWidth * sliderValTX,
                          // boxHeight * sliderValTY,
                        ),
                        bottomRight: Radius.elliptical(
                          //Bx .13, by = .11

                          boxWidth * .13,
                          boxHeight * .11,
                          // boxWidth * sliderValBX,
                          // boxHeight * sliderValBY,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
