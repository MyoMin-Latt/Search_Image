import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_image_p1/image_detail/image_detail.dart';
import 'package:search_image_p1/result/result_ob.dart';

class ResultWidget extends StatelessWidget {
  Hits hits;
  ResultWidget(this.hits, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ImageDetailPage(hits: hits);
          }));
        },
        child: Column(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              imageUrl: hits.webformatURL!,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //can only get 5 image with image widget, so can not use
                // Column(
                //   children: [
                //     ClipOval(
                //       clipBehavior: Clip.antiAlias,
                //       child: Image.network(hits.userImageURL!, width: 20, height: 20,),
                //     ),
                //     Text(
                //       hits.user.toString(),
                //       style: TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
                Column(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      hits.likes.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      hits.views.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.download,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      hits.downloads.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
