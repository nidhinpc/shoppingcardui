import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingcardui/controller/category_controller.dart';
import 'package:shoppingcardui/controller/my_cart_controller.dart';

import 'package:shoppingcardui/view/product_screen/product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<MyCartController>().initDb();

        await context.read<CategoryController>().getdata();

        await context.read<CategoryController>().getStore();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 30,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.favorite_outline_rounded,
                    size: 30,
                  ),
                  Text(
                    "Saved",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_mall_outlined,
                    size: 30,
                  ),
                  Text(
                    "Cart",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    size: 30,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Discover",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
          ),
          actions: [
            Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                Positioned(
                  right: 0,
                  top: 2,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.black,
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 20)
          ],
        ),
        body: Consumer<CategoryController>(
          builder: (context, providerObj, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 230, 228, 228),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              Icon(
                                Icons.search_outlined,
                                color: Colors.black,
                                size: 35,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Search Anything",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 129, 129, 129),
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Consumer<CategoryController>(
                    builder: (context, categoryObj, child) =>
                        SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          categoryObj.categorylist.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<CategoryController>()
                                    .onCategorySelection(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      categoryObj.selectedCategoryIndex == index
                                          ? Colors.black
                                          : Colors.grey,
                                ),
                                height: 50,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    categoryObj.categorylist[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          categoryObj.selectedCategoryIndex ==
                                                  index
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  providerObj.isProductLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemCount: providerObj.shopModels?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 250,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (providerObj.shopModels![index].id !=
                                          null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductScreen(
                                                      id: providerObj
                                                          .shopModels![index]
                                                          .id!),
                                            ));
                                      }
                                    },
                                    child: providerObj.isLoading
                                        ? CircularProgressIndicator()
                                        : Container(
                                            height: 180,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        providerObj
                                                                .shopModels?[
                                                                    index]
                                                                .image
                                                                .toString() ??
                                                            "not data"))),
                                          ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      height: 35,
                                      width: 35,
                                      child: Icon(
                                        Icons.favorite_outline,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                providerObj.shopModels?[index].title
                                        .toString() ??
                                    "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  textAlign: TextAlign.left,
                                  providerObj.shopModels?[index].price
                                          .toString() ??
                                      ""),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
