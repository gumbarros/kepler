import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final Function backFunction;

  Header(this.title, this.backFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
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
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: "JosefinSans",
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () async {
                          backFunction();
                        })
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
