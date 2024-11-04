import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Cart")),
        body: Form(
          key: _formKey,
          child: Column(
            children: List.generate(
              2,
              (index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  height: 200,
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
                            color: Colors.redAccent,
                          ),
                          Column(
                            children: [Text("Product Name"), Text("bjgk")],
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    height: 25,
                                    width: 30,
                                    color: const Color.fromARGB(
                                        255, 223, 141, 141),
                                    child: Icon(Icons.add)),
                              ),
                              Text("qty"),
                              InkWell(
                                onTap: () {},
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
                        onTap: () {},
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
