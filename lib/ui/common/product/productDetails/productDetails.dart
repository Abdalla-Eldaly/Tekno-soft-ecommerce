import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esayshop/domain/model/Product.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../my_theme.dart';
import 'Counter.dart';

class ProductDetails extends StatefulWidget {
  static String routeName = 'details';

  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _counter = 0;
  bool isDescriptionExpanded = false;
  int _currentImage = 1;
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    Product args = ModalRoute.of(context)!.settings.arguments as Product;
    int totalImages = args.images?.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: MyTheme.tittleproducttColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0.04,
              letterSpacing: -0.17,
            ),
          ),
        ),
        actions: [

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(

                children:[CarouselSlider(
                  items: args.images?.map((imageUrl) {
                    return CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 42,
                        ),
                      ),
                    );
                  }).toList() ?? [],
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    pauseAutoPlayOnTouch: true,
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    height: MediaQuery.of(context).size.height * 0.4,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImage = index + 1;
                      });
                    },
                  ),
                ),
                  Positioned(
                    bottom: 15,
                    right: 30,
                    child: Text(
                      '$_currentImage / $totalImages',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),),
                  Positioned(
                    top: 15,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });

                        if (_isFavorite) {

                          _showFavoriteMessage();
                        }
                      },
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                        size: 40,
                        color: _isFavorite ? Colors.red : MyTheme.BottonColor,
                      ),
                    ),
                  ),
                ]
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getFirstTwoWords(args.title) ?? "",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: MyTheme.tittleproducttColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                        letterSpacing: -0.17,
                      ),
                    ),
                  ),
                  Text(
                    'EGP ${args.price ?? ""}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: MyTheme.tittleproducttColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                        letterSpacing: -0.17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.cardborder, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      ' ${args.sold ?? ""} Sold',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: MyTheme.tittleproducttColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFF4B400),
                        size: 15,
                      ),
                      Text(
                        '${args.ratingsAverage} (${args.ratingsQuantity})',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: MyTheme.tittleproducttColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CounterWidget(
                    counter: _counter ?? 0,
                    onIncrement: () {
                      if (_counter! < (args.quantity ?? 0)) {
                        setState(() {
                          _counter = _counter! + 1;
                        });
                      }
                    },
                    onDecrement: () {
                      if (_counter! > 0) {
                        setState(() {
                          _counter = _counter! - 1;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: MyTheme.tittleproducttColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isDescriptionExpanded = !isDescriptionExpanded;
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          text: isDescriptionExpanded
                              ? args.description ?? ""
                              : _trimDescription(args.description ?? "", 3),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: MyTheme.TextDescription,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.17,
                            ),
                          ),
                          children: [
                            if (_isLongDescription(args.description ?? ""))
                              TextSpan(
                                text: isDescriptionExpanded
                                    ? " Read Less"
                                    : " Read More",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(color: MyTheme.cardborder, height: 2),
            ),
            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text('Total Price',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: MyTheme.TextDescription,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.17,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text('EGP ${args.price}',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: MyTheme.tittleproducttColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.17,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .65,
                      padding: const EdgeInsets.all(12),
                      color: MyTheme.BottonColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          Text('Add to Card',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.17,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _getFirstTwoWords(String? title) {
    if (title == null) return null;

    List<String> words = title.split(' ');

    List<String> firstTwoWords = words.take(2).toList();

    return firstTwoWords.join(' ');
  }

  String _trimDescription(String text, int maxLines) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 16.0),
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    if (textPainter.didExceedMaxLines) {
      TextPosition endOffset = textPainter.getPositionForOffset(
          Offset(MediaQuery.of(context).size.width, double.infinity));
      return '${text.substring(0, endOffset.offset).trim()}...';
    }

    return text;
  }

  bool _isLongDescription(String description) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: description,
        style: const TextStyle(fontSize: 16.0),
      ),
      maxLines: 3, // Change this value to the desired number of lines.
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    return textPainter.didExceedMaxLines;
  }
  void _showFavoriteMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        dismissDirection: DismissDirection.down,
 behavior: SnackBarBehavior.fixed,
shape: OutlineInputBorder(),
animation: kAlwaysCompleteAnimation,
elevation: 20,
        content: Text('Product added to favorites',style: TextStyle(fontSize: 14),),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
