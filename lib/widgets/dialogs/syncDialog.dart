import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyncDialog extends StatelessWidget {
  final RxBool success;
  final RxString syncMessage;
  final RxDouble syncPercentage;

  SyncDialog(
      {@required this.success,
      @required this.syncMessage,
      @required this.syncPercentage});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !success.value,
        child: WillPopScope(
          onWillPop: () async => success.value,
          child: Dialog(
            child: Container(
                width: Get.width / 1.4,
                height: Get.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width / 5,
                      height:  Get.width / 5, //Yes width, because CircularProgress needs to keep a aspect ratio
                      child: CircularProgressIndicator(
                        value: syncPercentage.value,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 10.0,
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 20,
                    ),
                    Text(syncMessage.value, style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,)
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
