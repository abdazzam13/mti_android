import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/response/listDataResponse.dart';
import '../utils/helper.dart';

class itemImage extends StatelessWidget {
  const itemImage({
    super.key,
    required this.context,
    required this.listData,
  });

  final BuildContext context;
  final ListDataResponse listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: const Color(0XFFC4C4C4).withOpacity(0.5))
      ]),
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child:
                  InkWell(
                    onTap: (){
                      showImageViewer(context, Image.network(listData.url!).image,
                          swipeDismissible: false);
                    },
                    child: Image.network(listData.thumbnailUrl!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Keterangan",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black),
              ),
              Text("${Helper().capitalizeFirstLetter(listData.title!)}", textAlign: TextAlign.center,),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}