import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kepler/views/planetview.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
          body: SafeArea(
              child: Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Kepler',
                        style: TextStyle(
                          fontSize: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(_planetPageRoute());
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(colors: [
                              Color(0xFFF667EEA),
                              Color(0xFFF764BA2)
                            ])),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Planet View',
                                  style: GoogleFonts.josefinSans(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ],
    );
  }
}

Route _planetPageRoute() {
  return CupertinoPageRoute(builder: (context) => PlanetView());
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: _height / 5,
            width: _width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(360),
              )
            ),
          )
        ],
      ),
    );
  }
}
