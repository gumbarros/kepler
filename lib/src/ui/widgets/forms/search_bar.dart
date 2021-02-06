import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SearchBar extends StatelessWidget {
  final RxString search;

  SearchBar(this.search);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
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
                  search.value = value;
                },
                style: TextStyle(
                  fontFamily: "Roboto"
                ),
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
              icon: Icon(Icons.search, color: Theme.of(context).textTheme.headline4.color),
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
    );
  }
}
