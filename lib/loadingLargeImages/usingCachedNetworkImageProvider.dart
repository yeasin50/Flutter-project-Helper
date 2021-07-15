import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///FIXMED:: large image laggy loading, current approach lags when find low networks
///Fixed by using Future
class FullScreenImage extends StatefulWidget {
  ///** using large image makes kindda laggy, we can use blurImage package to solve this(might be)
  ///* we need hash code for that

  final String imageUrl;

  //* hero tag is the thumbnails
  final String heroTag;

  FullScreenImage({
    Key? key,
    required this.imageUrl,
    required this.heroTag,
  }) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool onLoading = true;

  List<CachedNetworkImageProvider> cachedImages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        onLoading = false;
      });
    });
  }

  Future<CachedNetworkImageProvider> _loadAllImage(
      BuildContext context, String url) async {
    late CachedNetworkImageProvider cachedImage;

    var configuration = createLocalImageConfiguration(context);
    cachedImage = CachedNetworkImageProvider(url)..resolve(configuration);

    return cachedImage;
  }

  ///*FIXED::  if thumbnails makes lags , replace with container
  @override
  Widget build(BuildContext context) => Hero(
        tag: widget.heroTag,
        child: onLoading
            ?
            // Container()
            onLoadImage(widget.heroTag)
            : FutureBuilder(
                future: _loadAllImage(context, widget.imageUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CupertinoActivityIndicator();
                  if (snapshot.hasData)
                    return onLoadImage(widget.imageUrl);
                  else
                    return Text("Something went wrong");
                },
              ),
      );

  Widget onLoadImage(String imageUrl) {
    return Container(
      // color: Colors.cyanAccent,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fitWidth,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );

    // return ExtendedImage.network(
    //   imageUrl,
    //   fit: BoxFit.fill,
    //   cache: true,
    //   loadStateChanged: (ExtendedImageState state) {
    //     switch (state.extendedImageLoadState) {
    //       case LoadState.loading:
    //         return Text("laoding");

    //       ///if you don't want override completed widget
    //       ///please return null or state.completedWidget
    //       //return null;
    //       //return state.completedWidget;
    //       case LoadState.completed:
    //         return ExtendedRawImage(
    //           image: state.extendedImageInfo?.image,
    //           width: 400,
    //           height: 600,
    //         );
    //       case LoadState.failed:
    //         return Text("failed to load");
    //     }
    //   },
    // );

    // return Image.network(
    //   imageUrl,
    //   fit: BoxFit.fitWidth,
    //   scale: 1,
    //   alignment: Alignment.center,
    //   loadingBuilder: (context, child, loadingProgress) {
    //     return loadingProgress == null ? child : SizedBox();
    //   },
    // );
  }
}
