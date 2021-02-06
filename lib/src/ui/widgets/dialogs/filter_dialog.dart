import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/controllers/explore/stars_controller.dart';
import 'package:kepler/src/utils/kepler_utils.dart';
import 'package:kepler/src/ui/widgets/forms/text_field.dart';

class FilterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StarsController>(
      init: StarsController(),
      builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: Get.height / 1,
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
                Align(alignment: Alignment.topRight,child: IconButton(icon: Icon(Icons.replay, size: 20, semanticLabel: "clear_filters"),onPressed: (){
                  _.colorFilter = null;
                  _.massFrom = null;
                  _.massTo = null;
                  _.ageTo = null;
                  _.ageFrom = null;
                  _.radiusFrom = null;
                  _.radiusTo = null;
                  _.update();
                  Get.back();
                },),),
                Container(
                  width: Get.width,
                  height: Get.height / 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Column(children: [
                      Text("color".tr),
                      DropdownButton(
                          value: _.colorFilter,
                          style: TextStyle(),
                          onChanged: (value) {
                            _.colorFilter = value;
                            _.update();
                          },
                          items: KeplerUtils.colorDropdownItems)
                      ,
                    ],),
                    Column(children: [
                      Text("age".tr + " (${"million_years".tr})"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: Get.width / 4, child: KeplerTextField(initialValue: _.ageFrom,textAlign: TextAlign.center,numeral: true,onChanged: (value){
                               _.ageFrom = value;
                               _.update();
                          },)),
                          Text("to".tr),
                          Container(width: Get.width / 4, child: KeplerTextField(initialValue: _.ageTo,textAlign: TextAlign.center,numeral: true,onChanged: (value){
                            _.ageTo = value;
                            _.update();
                          },)),
                        ],
                      ),
                    ],),
                    Column(children: [
                      Text("${"mass".tr}" + " ${"solar_mass".tr}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: Get.width / 4, child: KeplerTextField(initialValue: _.massFrom,textAlign: TextAlign.center,numeral: true,onChanged: (value){
                            _.massFrom = value;
                            _.update();
                          },)),
                          Text("to".tr),
                          Container(width: Get.width / 4, child: KeplerTextField(initialValue: _.massTo,textAlign: TextAlign.center,numeral: true,onChanged: (value){
                            _.massTo = value;
                            _.update();
                          },)),

                        ],
                      ),
                    ],),
                      Column(children: [
                        Text("radius".tr + " ${"solar_radius".tr}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: Get.width / 4, child: KeplerTextField(initialValue: _.radiusFrom,textAlign: TextAlign.center,numeral: true,onChanged: (value){
                              _.radiusFrom = value;
                              _.update();
                            },)),
                            Text("to".tr),
                            Container(width: Get.width / 4, child: KeplerTextField(initialValue: _.radiusTo,textAlign: TextAlign.center,numeral: true,onChanged: (value){
                              _.radiusTo = value;
                              _.update();
                            },)),

                          ],
                        ),
                      ],)
                  ],)
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('filter'.tr),
                  onPressed: () {
                    Get.back();
                  },
                ),

              ],
            ),
          )),
    );
  }
}
