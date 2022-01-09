import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_image_p1/result/result_ob.dart';

class ResultWidget extends StatelessWidget {
  Hits hits;
  ResultWidget(this.hits, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            imageUrl: hits.webformatURL!,
            progressIndicatorBuilder: (context, url, downloadProgress) => 
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.thumb_up, color: Colors.blue,),
                  Text(hits.likes.toString(), style: TextStyle(fontWeight: FontWeight.bold),),                  
                ],
              ),

              Column(
                children: [
                  Icon(Icons.remove_red_eye, color: Colors.blue,),
                  Text(hits.views.toString(), style: TextStyle(fontWeight: FontWeight.bold),),                  
                ],
              ),

              Column(
                children: [
                  Icon(Icons.download, color: Colors.blue,),
                  Text(hits.downloads.toString(), style: TextStyle(fontWeight: FontWeight.bold),),                  
                ],
              ),

            ],
          )
        ],
      ),
    );
  }
}