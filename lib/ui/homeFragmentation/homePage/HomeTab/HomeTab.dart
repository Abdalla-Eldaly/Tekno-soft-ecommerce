import 'package:carousel_slider/carousel_slider.dart';
import 'package:esayshop/domain/model/Brands.dart';
import 'package:esayshop/domain/model/Product.dart';
import 'package:esayshop/my_theme.dart';
import 'package:esayshop/ui/homeFragmentation/homePage/DetailsViewAll/DetailsViewAll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../di/di.dart';
import '../../../../domain/model/Category.dart';
import '../../../common/product/ProductWidget.dart';
import 'HomeBrandWidget.dart';
import 'HomeCategoryWidget.dart';
import 'HomeTabViewModel.dart';

class HomeTab extends StatefulWidget {
  static String routeName = 'dad';
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.intipage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTabViewModel, HomeTabState>(
      buildWhen: (previous, current) {
        if (current is Loading) return false;
        if (current is Error) return false;
        if (current is Success) return true;
        return true;
      },
      listenWhen: (previous, current) {
        if (current is Loading) return true;
        if (current is Error) return true;
        return false;
      },
      bloc: viewModel,
      builder: (context, state) {
        if (state is Success) {
          return buildSuccessWidget(
              state.categories, state.brands, state.products);
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {
        if (state is Loading) {}
        if (state is Error) {}
      },
    );
  }

  Widget buildSuccessWidget(List<Category>? categories, List<Brand>? brands,
      List<Product>? products) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: CarouselSlider(
                    items: [
                      Image.asset(
                        'assets/images/Property 1=Default.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/Property 1=Variant2.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/Property 1=Variant3.png',
                        fit: BoxFit.cover,
                      ),
                      // Add more images as needed
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: const Duration(seconds: 7),
                      autoPlayInterval: const Duration(seconds: 30),
                      pauseAutoPlayOnTouch: true,
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      height: MediaQuery.of(context).size.height * 0.4,
                      viewportFraction: 1.0,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 25),
              ),
              SliverToBoxAdapter(
                child: SizedBox.fromSize(
                  size: const Size.fromHeight(320),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: MyTheme.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 0.06,
                                letterSpacing: -0.17,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return HomeCategoryWidget(categories![index]);
                          },
                          itemCount: categories?.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 50),
              ),
              // SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 120,
              //     child: Column(children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'Popular Brands',
              //             style: GoogleFonts.poppins(
              //               textStyle: const TextStyle(
              //                 color: MyTheme.primaryColor,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w500,
              //                 height: 0.06,
              //                 letterSpacing: -0.17,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Expanded(
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: brands?.length ?? 0,
              //
              //           itemBuilder: (context, index) {
              //             print("Creating HomeBrandWidget for index $index");
              //             print('objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject');
              //             if (brands != null && index < brands.length) {
              //               return Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                 child: HomeBrandWidget(brands![index]),
              //               );
              //             } else {
              //               return Container();
              //             }
              //           },
              //         ),
              //       ),
              //
              //
              //     ]),
              //   ),
              // ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Most Salles',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: MyTheme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                              letterSpacing: -0.17,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ViewAll.routeName);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'View all',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: MyTheme.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 0.12,
                                    letterSpacing: -0.17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: CarouselSlider.builder(
                        itemCount: products?.length ?? 0, // Use the length of the products list
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          disableCenter: false,
                          height: MediaQuery.of(context).size.height * 0.6,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.6,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return ProductWidget(products![index]);
                        },
                      ),
                    ),

                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
