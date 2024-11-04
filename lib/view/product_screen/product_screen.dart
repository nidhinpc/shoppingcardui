import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcardui/controller/my_cart_controller.dart';

import 'package:shoppingcardui/controller/product_detail_control.dart';
import 'package:shoppingcardui/view/my_cart/my_cart.dart';

class ProductScreen extends StatefulWidget {
  final int id;
  const ProductScreen({required this.id, super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<ProductDetailControl>().getProductdetail(widget.id);
      },
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            Stack(
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                Positioned(
                    right: 0,
                    top: 3,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 10,
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ))
              ],
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(child: Consumer<ProductDetailControl>(
            builder: (context, productprovider, child) {
              return productprovider.isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 400,
                              width: 400,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        productprovider.product!.image
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.favorite_outline,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          productprovider.product!.title.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 5),
                            RatingBar.readOnly(
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              initialRating:
                                  productprovider.product?.rating?.rate ?? 0,
                              maxRating: 5,
                            ),
                            Text(
                              "${productprovider.product!.rating!.rate.toString()}/5 Rating",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 97, 94, 94)),
                            ),
                            SizedBox(width: 25),
                          ],
                        ),
                        Text(
                          "Rating Count - ${productprovider.product!.rating!.count} ",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 95, 92, 92),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          productprovider.product!.description.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          productprovider.product!.id.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Choose size",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border:
                                      Border.all(width: 2, color: Colors.grey)),
                              child: Center(
                                  child: Text(
                                "S",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border:
                                      Border.all(width: 2, color: Colors.grey)),
                              child: Center(
                                  child: Text(
                                "M",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border:
                                      Border.all(width: 2, color: Colors.grey)),
                              child: Center(
                                  child: Text(
                                "L",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                            )
                          ],
                        )
                      ],
                    );
            },
          )),
        )),
        bottomNavigationBar: Consumer<ProductDetailControl>(
          builder: (context, priceprovider, child) => Padding(
            padding: const EdgeInsets.all(10),
            child: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.blueGrey),
                      ),
                      Text(
                        priceprovider.product?.price.toString() ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context
                            .read<MyCartController>()
                            .addProduct(priceprovider.product!);
                        context.read<MyCartController>().getAllProducts();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyCart(),
                            ));
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_mall_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
