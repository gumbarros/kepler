import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_format/date_format.dart' as f;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/src/controllers/mars/marsController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/marsData.dart';
import 'package:kepler/src/models/roverData.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/dialogs/marsFIndDialog.dart';
import 'package:kepler/src/ui/widgets/progress/loading.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class MarsView extends StatelessWidget {
  final RoverData rover = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: GetBuilder<MarsController>(
        init: new MarsController(),
        builder: (_) => Stack(
          children: [
            Background(),
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "${rover.name} - ${_.getTitle()}",
                  style: KeplerTheme.theme.textTheme.caption,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Get.dialog(MarsFindDialog(rover));
                      })
                ],
              ),
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomPadding: false,
              body: FutureBuilder<List<MarsData>>(
                  future: _.getMarsData(rover.name, _.page),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MarsData>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return Loading();
                      default:
                        if (snapshot.data.isNull) {
                          return Loading();
                        }
                        if (snapshot.data.isEmpty) {
                          return Center(
                            child: Text(
                              string.text("no_photos_found"),
                              style: KeplerTheme.theme.textTheme.caption,
                            ),
                          );
                        }
                        return GridView.builder(
                            padding: EdgeInsets.all(10.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0),
                            itemCount: snapshot.data.length + 1,
                            itemBuilder: (context, index) {
                              if (index != snapshot.data.length)
                                return GestureDetector(
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: (snapshot.data[index].imgSrc),
                                    height: 300.0,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {},
                                  onLongPress: () {
                                    Share.share(snapshot.data[index].imgSrc);
                                  },
                                );
                              else
                                return Container(
                                  child: GestureDetector(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 70.0,
                                        ),
                                        Text(
                                          string.text("load_more"),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22.0),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      _.page += 1;
                                      _.update();
                                    },
                                  ),
                                );
                            });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
