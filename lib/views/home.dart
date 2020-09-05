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
          backgroundColor: Colors.transparent,
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: _height * 0.14,
            left: _width * 0.56,
            child: Container(
              height: _height * 0.14,
              width: _width * 0.14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black45,
              ),
            ),
          ),
          Positioned(
            top: _height * 0.29,
            left: _width * 0.41,
            child: Container(
              height: _height * 0.12,
              width: _width * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black38,
              ),
            ),
          ),
          Positioned(
            top: _height *  0.3,
            left: _width * 0.72,
            child: Container(
              height: _height * 0.09,
              width: _width * 0.09,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: _height / 2.5,
                    width: _width / 1.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.black26,
                          Colors.black12,
                        ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(360),
                          topRight: Radius.zero,
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: _height / 3,
                width: _width / 2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black12, Colors.black26]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(360),
                    )),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
