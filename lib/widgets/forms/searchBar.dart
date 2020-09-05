import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  final Function onChanged;
  SearchBar({@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Container(
            width: Get.width / 1.05,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      onChanged: (String value) {
                        onChanged(value);
                      },
                      style: GoogleFonts.robotoCondensed(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white54),
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
