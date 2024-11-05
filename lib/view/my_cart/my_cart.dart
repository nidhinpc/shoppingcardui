import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcardui/controller/my_cart_controller.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<MyCartController>().getAllProducts();
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Cart")),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
              context.watch<MyCartController>().storedProducts.length,
              (index) {
                final cartController = context.watch<MyCartController>();
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  height: 270,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 152, 155, 157)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                              cartController.storedProducts[index]["image"],
                            ))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  cartController.storedProducts[index]["name"],
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  cartController.storedProducts[index]
                                      ["discription"],
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  int currentQty = cartController
                                      .storedProducts[index]['qty'];
                                  cartController.incrementQty(
                                      cartController.storedProducts[index]
                                          ['productId'],
                                      currentQty);
                                },
                                child: Container(
                                    height: 25,
                                    width: 30,
                                    color: const Color.fromARGB(
                                        255, 223, 141, 141),
                                    child: Icon(Icons.add)),
                              ),
                              Text(
                                context
                                    .watch<MyCartController>()
                                    .storedProducts[index]["qty"]
                                    .toString(),
                              ),
                              InkWell(
                                onTap: () {
                                  int currentQty = cartController
                                      .storedProducts[index]['qty'];
                                  cartController.decrementQty(
                                      cartController.storedProducts[index]
                                          ['productId'],
                                      currentQty);
                                },
                                child: Container(
                                    height: 25,
                                    width: 30,
                                    color: const Color.fromARGB(
                                        255, 223, 141, 141),
                                    child: Icon(
                                      Icons.remove,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<MyCartController>().removeProduct(
                              cartController.storedProducts[index]
                                  ['productId']);
                        },
                        child: Container(
                          height: 50,
                          width: 700,
                          color: Colors.redAccent,
                          child: Center(child: Text("Remove")),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
