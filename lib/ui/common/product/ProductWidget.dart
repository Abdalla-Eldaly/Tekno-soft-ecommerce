import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esayshop/my_theme.dart';
import 'package:esayshop/ui/common/product/productDetails/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/database/databaseUtlis.dart';
import '../../../domain/model/Product.dart';
import '../../../provider/currentprovider.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  ProductWidget(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isFavorite = false;
  var isSelected;
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  void _loadFavoriteState() async {
    final collection = FirebaseFirestore.instance.collection('favorites');

    final documentId = widget.product.id.toString();

    final document = await collection.doc(documentId).get();

    setState(() {
      _isFavorite = document.exists ? document['isFavorite'] : false;
    });
  }

  void _saveFavoriteState() async {
    // Get the reference to the Firestore collection
    final collection = FirebaseFirestore.instance.collection('favorites');

    // Use the product ID as the document ID
    final documentId = widget.product.id.toString();

    // Set the favorite state in Firestore
    await collection.doc(documentId).set({'isFavorite': _isFavorite});
  }

  @override
  Widget build(BuildContext context) {
    CounterProvider counterProvider = Provider.of<CounterProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: MyTheme.cardborder, width: 2),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ProductDetails.routeName,arguments: widget.product);
                  },
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(

                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                        ),
                      );
                    },
                    imageUrl: widget.product.imageCover ?? "",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => _buildErrorWidget(),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _getFirstTwoWords(widget.product.title) ?? "",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: MyTheme.tittleproducttColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                        letterSpacing: -0.17,
                      ),
                    ),
                  ),

                ),
              ),
              const SizedBox(height: 5,),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'EGP ${widget.product.priceAfterDiscount?.toString() ?? widget.product.price?.toString() ?? ""}',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: MyTheme.tittleproducttColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0.09,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.product.priceAfterDiscount != null,
                      child: Text(
                        '${widget.product.price?.toString() ?? ""} EGP',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: MyTheme.discountColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Review ( ${widget.product.ratingsAverage} )',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: MyTheme.primaryColor,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0.12,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0,bottom: 8),
                      child: Icon(Icons.star,color: Color(0xFFF4B400),size: 15,),
                    )


                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 15,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isFavorite = !_isFavorite;

                  if (_isFavorite) {
                    counterProvider.increment();
                  } else {
                    counterProvider.decrement();
                  }


                });

                _saveFavoriteState();
                print('counter ======================== ${counterProvider.counter}');
              },
              child: Icon(
                _isFavorite ? Icons.check_circle_outline : Icons.add_circle,
                size: 40,
                color: _isFavorite ? Colors.green : MyTheme.BottonColor,
              ),
            ),
          ),

        ],
      ),
    );


  }

  Widget _buildErrorWidget() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey,
      child: const Center(
        child: Icon(
          Icons.error,
          color: Colors.red,
          size: 50,
        ),
      ),
    );
  }
  Future<void> checkMovieInFireStore ()async{
    QuerySnapshot<Product> temp = await DatabaseUtils.readProductFromFirebase(widget.product.id!);
    if(temp.docs.isEmpty){
    }else{
      widget.product.id=temp.docs[0].data().id;
      isSelected=1;
      setState(() {
      });
    }
  }
}
String? _getFirstTwoWords(String? title) {
  if (title == null) return null;

  List<String> words = title.split(' ');

  List<String> firstTwoWords = words.take(2).toList();

  return firstTwoWords.join(' ');
}
