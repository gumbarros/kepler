import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String title;
  final AnimationController fadeController;
  final AnimationController scaleController;

  Header(this.title, {@required this.fadeController, @required this.scaleController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(title, style: GoogleFonts.josefinSans(fontSize: 50)),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () async {
                    fadeController.reverse();
                    await scaleController.reverse();
                    Navigator.pop(context);
                  })
            ],
          ),
        ],
      ),
    );
  }
}
