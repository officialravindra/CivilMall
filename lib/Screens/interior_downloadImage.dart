import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class InteriorDownloadImageScreen extends StatefulWidget {
  String image;
  InteriorDownloadImageScreen({Key? key,required this.image}) : super(key: key);

  @override
  State<InteriorDownloadImageScreen> createState() => _InteriorDownloadImageScreenState(image);
}

class _InteriorDownloadImageScreenState extends State<InteriorDownloadImageScreen> {
  String image;
  _InteriorDownloadImageScreenState(this.image);

  downLoadimage(String image)async{
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(image);
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      Fluttertoast.showToast(
          msg: "Downloaded Succesfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(path);
    } on Exception catch (error) {
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: Container(
                width: double.infinity,
                child: PhotoView(
                  imageProvider:
                  CachedNetworkImageProvider(image),
                )
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              height: 40,
              width: 100,
              child: Material(
                color: MyTheme.skyblue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 6.0,
                //shadowColor: Colors.grey[50],

                child: InkWell(
                  splashColor: const Color(0x8034b0fc),
                  onTap: () {
                    downLoadimage(image);
                  },
                  child: Container(

                    //decoration: ,

                    child: Center(
                      child: Text(
                        'Download',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
