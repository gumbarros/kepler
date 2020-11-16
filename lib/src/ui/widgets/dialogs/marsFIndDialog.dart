import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/controllers/mars/marsController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/enums/marsDate.dart';
import 'package:kepler/src/models/roverData.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:kepler/src/ui/widgets/forms/textField.dart';

class MarsFindDialog extends StatelessWidget {
  final RoverData rover;
  MarsFindDialog(this.rover);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarsController>(
        init: MarsController(),
        builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
                height: Get.height / 2,
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                margin: EdgeInsets.only(top: 66),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: ListView(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.replay,
                          size: 20,
                          semanticLabel: string.text("clear_filters"),
                        ),
                        onPressed: () {
                          _.update();
                          Get.back();
                        },
                      ),
                    ),
                    Container(
                        width: Get.width,
                        height: Get.height / 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(string.text("date")),
                            Obx(() => Row(
                                  children: [
                                    Container(
                                        width: Get.width / 3,
                                        height: Get.height / 12,
                                        child: RadioListTile(
                                            value: MarsDate.SOL,
                                            title: Text("SOL",
                                                style: KeplerTheme
                                                    .theme.textTheme.subtitle1),
                                            groupValue: _.marsDate.value,
                                            onChanged: (value) {
                                              _.setDate(value);
                                            })),
                                    Container(
                                        width: Get.width / 3,
                                        height: Get.height / 12,
                                        child: RadioListTile(
                                            value: MarsDate.EARTH,
                                            title: Text(string.text("earth"),
                                                style: KeplerTheme
                                                    .theme.textTheme.subtitle1),
                                            groupValue: _.marsDate.value,
                                            onChanged: (value) {
                                              _.setDate(value);
                                            })),
                                  ],
                                ))
                          ],
                        )),
                    Obx(
                      () => Visibility(
                        replacement: DateTimePicker(
                          initialValue: '',
                          //firstDate: DateTime.parse(rover.landingDate) ,
                          icon: Icon(Icons.date_range),
                          lastDate:DateTime.parse(rover.maxDate),
                          dateLabelText: string.text("date"),
                          onChanged: (val){
                            print(val);
                          },
                        ),
                        visible: _.marsDate.value == MarsDate.SOL,
                        child: Container(
                            height: Get.height / 8,
                            child: KeplerTextField(
                              textAlign: TextAlign.center,
                              label: "SOL",
                              onChanged: (value) {},
                            )),
                      ),
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(string.text('filter')),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ))));
  }
}
