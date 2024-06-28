import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/custom_colors.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';

class ApodTile extends StatelessWidget {
  final ApodEntity apod;
  final Function() onTap;
  const ApodTile({super.key, required this.apod, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: "apod-${apod.date.toString()}",
        //tentativa para acabar com o overflow, funcionou ao usar o Material
        flightShuttleBuilder: (BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext) {
          return SingleChildScrollView(
            child: toHeroContext.widget,
          );
        },
        child: Material(
          // outro widget que auxiliou a acabar com o overflow do hero
          type: MaterialType
              .transparency, //coloquei pois aparecia um fundo branco ao adicionar o material
          child: Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(apod.thumbnailUrl ?? apod.url!),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                          color: CustomColors.white.withOpacity(.5))),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: CustomColors.black.withOpacity(.6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    apod.title ?? "",
                                    style: TextStyle(
                                      color: CustomColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    apod.explanation ?? "",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: CustomColors.white,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: CustomColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
