import 'package:flutter/material.dart';
import 'package:kepler/src/ui/theme.dart';

class Header extends StatelessWidget {
  final String title;
  final Function onPressed;

  Header(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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
                      style: KeplerTheme.theme.textTheme.headline1,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: onPressed)
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
