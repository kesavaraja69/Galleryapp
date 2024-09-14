import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/app/constants/app_route_constants.dart';
import 'package:galleryapp/app/constants/constants.dart';
import 'package:galleryapp/app/constants/sizeconfig.dart';
import 'package:galleryapp/core/model/fetchimages.data.dart';
import 'package:go_router/go_router.dart';

class ListOfImages extends StatelessWidget {
  final List<Fetchimagesdatamodel?>? data;
  final ScrollController controller;
  final bool loading;
  final BoxConstraints constraints;
  const ListOfImages(
      {super.key,
      required this.data,
      required this.controller,
      required this.loading,
      required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          controller: controller,
          primary: false,
          scrollDirection: Axis.vertical,
          itemCount: data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: constraints.maxWidth > 950
                ? 0.75 //! Aspect ratio for large screens (Desktop)
                : constraints.maxWidth > 600
                    ? 0.98 //! Aspect ratio for medium screens (Tablet)
                    : 1.35, //! Aspect ratio for small screens (Mobile)

            crossAxisCount: constraints.maxWidth > 950
                ? 6 //! Number of columns for large screens (Desktop)
                : constraints.maxWidth > 600
                    ? 4 //! Number of columns for medium screens (Tablet)
                    : 2, //! Number of columns for small screens (Mobile)
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      //! Go router  Navigate to the full screen image view on tap
                      (context).pushNamed(
                          MyAppRouteConstants.fullScreenimageRouteName,
                          pathParameters: {
                            'imageUrl': '${data![index]!.largeImageURL}'
                          });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => FullScreenImage(
                      //         imageUrl: widget.data![index]!.largeImageURL
                      //             .toString()),
                      //   ),
                      // );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        topLeft: Radius.circular(7),
                      ),

                      //! It allows you to display images from the web with caching capabilities, which can improve performance and reduce network usage by storing images locally after the first load.
                      child: CachedNetworkImage(
                        height: constraints.maxWidth > 950
                            ? SizeConfig.screenWidth! * 0.19
                            : constraints.maxWidth > 600
                                ? SizeConfig.screenWidth! * 0.2
                                : SizeConfig.screenHeight! * 0.128,
                        width: SizeConfig.screenWidth,
                        imageUrl: data![index]!.largeImageURL.toString(),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight! * 0.030,
                    width: SizeConfig.screenWidth!,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            limitText(data![index]!.user.toString(), 7),
                            style: kPopinsRegular.copyWith(
                                color: BConstantColors.txt3Color,
                                fontSize: constraints.maxWidth > 950
                                    ? SizeConfig.screenWidth! * 0.006
                                    : constraints.maxWidth > 600
                                        ? SizeConfig.screenWidth! * 0.013
                                        : SizeConfig.screenWidth! * 0.025),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            iconwithtext(
                              icon: CupertinoIcons.hand_thumbsup_fill,
                              text: data![index]?.likes.toString(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: iconwithtext(
                                icon: CupertinoIcons.eye_fill,
                                text: data![index]?.views.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  // Function to limit text to a certain number of characters
  String limitText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return text.substring(0, limit); // Limit text to 'limit' characters
    }
  }

//! reusable widget
  Widget iconwithtext({icon, text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: constraints.maxWidth > 950
              ? SizeConfig.screenWidth! * 0.009
              : constraints.maxWidth > 600
                  ? SizeConfig.screenWidth! * 0.013
                  : SizeConfig.screenWidth! * 0.027,
          color: BConstantColors.txt3Color,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            text,
            style: kPopinsRegular.copyWith(
                color: BConstantColors.txt3Color,
                fontSize: constraints.maxWidth > 950
                    ? SizeConfig.screenWidth! * 0.006
                    : constraints.maxWidth > 600
                        ? SizeConfig.screenWidth! * 0.013
                        : SizeConfig.screenWidth! * 0.025),
          ),
        )
      ],
    );
  }
}
