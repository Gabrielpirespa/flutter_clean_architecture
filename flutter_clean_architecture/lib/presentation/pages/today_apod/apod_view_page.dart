import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/date_convert.dart';
import 'package:flutter_clean_architecture/custom_colors.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/presentation/widgets/today_apod/apod_video.dart';
import 'package:flutter_clean_architecture/presentation/widgets/today_apod/apod_view_button.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class ApodViewPage extends StatefulWidget {
  final ApodEntity apod;
  const ApodViewPage({required this.apod, super.key});

  @override
  State<ApodViewPage> createState() => _ApodViewPageState();
}

class _ApodViewPageState extends State<ApodViewPage> {
  late ApodEntity apod;

  bool isImage = true;

  @override
  void initState() {
    apod = widget.apod;
    checkMediaType();
    super.initState();
  }

  void checkMediaType() {
    if (apod.mediaType == "video") {
      isImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        actions: [
          PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: CustomColors.white,
              ),
              color: CustomColors.black,
              itemBuilder: (context) => buildMenuButtons()),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [CustomColors.spaceBlue, CustomColors.black],
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Hero(
                    tag: "apod-${apod.date.toString()}",
                    child: ClipRRect(
                      child: buildMediaType(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 350, 30, 0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerLeft,
                          colors: [
                            CustomColors.black,
                            CustomColors.spaceBlue,
                            CustomColors.purple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: CustomColors.white.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue.withOpacity(0.7),
                            blurRadius: 10,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apod.title ?? "",
                            style: TextStyle(
                                fontSize: 22,
                                color: CustomColors.white,
                                fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            apod.explanation ?? "",
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "by ${apod.copyright ?? "NASA"}",
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                          Text(
                            "date: ${DateConvert.dateToString(apod.date)} (YYYY-MM-DD)",
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    ApodViewButton(
                      icon: Icons.open_in_browser,
                      title: "Show Media",
                      description:
                          "If the media is unavailable in app, tap here to see it on browser",
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ApodViewButton(
                      icon: Icons.bookmark_outline,
                      title: "Save",
                      description:
                          "Save this content for quickly access in the future",
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMediaType() {
    if (isImage) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/fullImage",
            arguments: apod.hdurl ?? apod.url ?? "",
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(apod.url ?? ""),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            border: Border.all(
              color: CustomColors.white.withOpacity(0.5),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(apod.thumbnailUrl ??
                "https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          border: Border.all(
            color: CustomColors.white.withOpacity(0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ApodVideo(url: apod.url ?? "")],
        ),
      );
    }
  }

  List<PopupMenuItem> buildMenuButtons() {
    List<PopupMenuItem> list = [];

    if (isImage) {
      list.add(
        PopupMenuItem(
          onTap: saveOnGallery,
          child: Text(
            "Save Image on Gallery",
            style: TextStyle(color: CustomColors.white),
          ),
        ),
      );
    }

    list.addAll([
      PopupMenuItem(
        onTap: shareOnlyLink,
        child: Text(
          "Share media only",
          style: TextStyle(color: CustomColors.white),
        ),
      ),
      PopupMenuItem(
        onTap: shareAllContent,
        child: Text(
          "Share all content",
          style: TextStyle(color: CustomColors.white),
        ),
      ),
    ]);

    return list;
  }

  void saveOnGallery() {
    if (isImage) {
      GallerySaver.saveImage(apod.hdurl ?? apod.url ?? "").then((value) {
        if (value == true) {
          setState(() {
            showSnackBar("Image saved on gallery");
          });
        }
      });
    }
  }

  void shareOnlyLink() {
    Share.share(apod.hdurl ?? apod.url ?? "");
  }

  void shareAllContent() {
    String link = apod.hdurl ?? apod.url ?? "";
    Share.share(
        "${apod.title}\n\n${apod.explanation}\n\nlink: $link\n\nby: ${apod.copyright}");
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }
}
