import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/src/controllers/favorites/favoritesController.dart';
import 'package:kepler/src/controllers/explore/planetController.dart';
import 'package:kepler/src/controllers/explore/starsController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/planetData.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/planetCard.dart';
import 'package:kepler/src/ui/widgets/cards/starCard.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';
import 'package:kepler/src/ui/widgets/universe/gasPlanet.dart';
import 'package:kepler/src/ui/widgets/universe/smallPlanet.dart';


class FavoritesView extends StatelessWidget{

  final RxDouble position = 0.0.obs;

  final List favorites = FavoritesController.to.getAllFavorites();

  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Get.put<PlanetController>(PlanetController());
    Get.put<StarsController>(StarsController());
    return GetBuilder<FavoritesController>(
      initState: (state){
        scrollController.addListener(() {
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
              position.value >= -Get.height / 2) {
            position.value -= 30;


          } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
              position.value <= -10) {
            position.value += 30;
            if (scrollController.offset == 0) {
              position.value = 0;
            }
          }
        });
      },
      dispose: (state) {
        scrollController.dispose();
      },
      builder: (_) => Stack(
        children: [
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomPadding: false,
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    Container(
                      child: Header(
                          string.text("favourites"), () => Get.back(canPop: true)),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: favorites.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(favorites[index].runtimeType == PlanetData)
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: PlanetCard(
                              width: Get.width - Get.width / 4,
                              height: Get.height / 5,
                              text:
                              "${favorites[index].planetName}" ?? "",
                              onTap: () => Get.toNamed('/planet',arguments:[index,favorites[index]]),
                              child: PlanetController.to
                                  .getPlanetsColor(favorites[index].bmvj) ==
                                  Colors.yellow[100]
                                  ? GasPlanet(
                                favorites[index].planetName,
                                index: index,
                                color: PlanetController.to
                                    .getPlanetsColor(favorites[index].bmvj),
                                size: 100,
                              )
                                  : SmallPlanet(
                                favorites[index].planetName,
                                index: index,
                                color: PlanetController.to
                                    .getPlanetsColor(favorites[index].bmvj),
                                size: 100,
                              ),),
                        ),
                      );
                      else
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: StarCard(
                            size: Get.width / 3.3,
                            index: index,
                            
                            text: favorites[index].name,
                            temperature:  favorites[index].temperature,
                            onTap: () =>
                                Get.toNamed(
                                                        '/solarSystem',
                                                        arguments: [
                                                          index,
                                                          favorites[index]
                                                        ]),
                          ),
                        );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
