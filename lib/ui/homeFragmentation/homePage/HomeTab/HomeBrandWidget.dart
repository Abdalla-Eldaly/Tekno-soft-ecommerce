import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/Brands.dart';

class HomeBrandWidget extends StatelessWidget {
  Brand brand;
  HomeBrandWidget(this.brand);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 100,
              height: 100, // Adjust the percentage as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider),
              ),
            );
          },
          imageUrl: brand.image ?? "",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        ),


      ],
    );
  }
}