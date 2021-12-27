import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/controllers/mars/mars_controller.dart';
import 'package:kepler/src/models/enums/mars_date.dart';
import 'package:kepler/src/models/rover_data.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:kepler/src/ui/widgets/forms/text_field.dart';

class MarsFindDialog extends StatelessWidget {
  final RoverData rover;

  MarsFindDialog(this.rover);

  @override
  Widget build(BuildContext context) {
    print(rover.toMap().toString());
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
                          semanticLabel: "clear_filters".tr,
                        ),
                        onPressed: () {
                          _.marsDate.value = MarsDate.NONE;
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
                            Text("date".tr),
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
                                            title: Text("earth".tr,
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
                        replacement: Visibility(
                          visible: _.marsDate.value != MarsDate.NONE,
                          child: GestureDetector(
                            onTap: () {
                              _.setEarthDate(context, rover);
                            },
                            child: KeplerTextField(
                              enabled: false,
                              controller: _.earthDate.value,
                              icon: Icons.calendar_today_rounded,
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        visible: _.marsDate.value == MarsDate.SOL,
                        child: Container(
                          height: Get.height / 8,
                          child: DropdownSearch<String>(
                              mode: Mode.BOTTOM_SHEET,
                              showSelectedItem: true,
                              showSearchBox: true,
                              items: _.getItems(rover.maxSol),
                              label: "SOL",
                              emptyBuilder: (BuildContext context, String s) {
                                return Center(child: Text("no_sol".tr));
                              },
                              onChanged: (value) {
                                _.solDate.value = value;
                              },
                              selectedItem: _.solDate.value),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: _.marsDate.value != MarsDate.NONE &&
                            (!_.solDate.value.isNullOrBlank ||
                                _.apiDate.value != ""),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Get.theme.primaryColor),
                          child: Text('filter'.tr),
                          onPressed: () {
                            _.update();
                            Get.back();
                          },
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
