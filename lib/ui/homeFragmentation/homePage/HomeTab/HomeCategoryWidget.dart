import 'package:cached_network_image/cached_network_image.dart';
import 'package:esayshop/domain/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/model/Brands.dart';

class HomeCategoryWidget extends StatelessWidget {
  Category category;
  HomeCategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 100.h,
              height: MediaQuery.of(context).size.height * 0.15.h, // Adjust the percentage as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider),
              ),
            );
          },
          imageUrl: category.image ?? "",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        ),
        SizedBox(height: 8),
        Text(category.name ?? ""),
      ],
    );
  }
}