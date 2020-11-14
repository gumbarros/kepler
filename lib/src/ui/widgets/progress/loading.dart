import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitRing( //Changed from ChasingDots to Ring for consistency with SyncDialog
        size: 50,
        color:  Colors.white,
      ),
    );
  }
}
