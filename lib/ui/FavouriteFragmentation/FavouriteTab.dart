import 'package:flutter/material.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Expanded(
              //     child: ListView.builder(
              //   itemCount: (products?.length ?? 0) ,
              //   itemBuilder: (context, index) {
              //     return Row(
              //       children: [
              //         Expanded(
              //           child: Container(
              //             height: MediaQuery.of(context).size.height * 0.45,
              //             child: ProductWidget(
              //               products![index],
              //             ),
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ))
            ],
          ),
        ),
      ),
    );
  }
}
