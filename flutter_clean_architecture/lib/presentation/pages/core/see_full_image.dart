import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/custom_colors.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SeeFullImage extends StatefulWidget {
  final String url;
  const SeeFullImage({super.key, required this.url});

  @override
  State<SeeFullImage> createState() => _SeeFullImageState();
}

class _SeeFullImageState extends State<SeeFullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: CustomColors.spaceBlue,
        elevation: 0,
        actions: [
          TextButton.icon(
              onPressed: saveOnGallery,
              icon: Icon(
                Icons.download,
                color: CustomColors.white,
              ),
              label: Text(
                "Save on gallery",
                style: TextStyle(color: CustomColors.white),
              ))
        ],
      ),
      body: SizedBox(
          height: double.infinity,
          child: InteractiveViewer(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                clipBehavior: Clip.none,
                child: Image.network(
                  widget.url,
                  fit: BoxFit.contain,
                  loadingBuilder: ((context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator()),
                      );
                    }
                  }),
                ),
              ),
            ),
          )),
    );
  }

  void saveOnGallery() {
    GallerySaver.saveImage(widget.url).then((value) {
      if (value == true) {
        setState(() {
          showSnackBar("Image saved on gallery");
        });
      }
    });
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }
}
