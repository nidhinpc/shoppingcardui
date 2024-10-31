// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shoppingcardui/controller/category_controller.dart';
// import 'package:shoppingcardui/controller/home_controller.dart';
// import 'package:shoppingcardui/view/product_screen/product_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (timeStamp) {
//         context.read<HomeScreenController>().getStore();
//         context.read<CategoryController>().getdata();
//       },
//     ); // TODO: implement initState
//     super.initState();
//   }

//   final ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Discover",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           Stack(
//             children: [
//               Icon(
//                 Icons.notifications_active_outlined,
//                 color: Colors.black,
//                 size: 35,
//               ),
//               Positioned(
//                 right: 0,
//                 child: CircleAvatar(
//                   radius: 8,
//                   backgroundColor: Colors.black,
//                   child: Text(
//                     "1",
//                     style: TextStyle(color: Colors.white, fontSize: 9),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             width: 10,
//           ),
//         ],
//       ),
//       body: Consumer<HomeScreenController>(
//         builder: (context, providerObj, child) => Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           height: 55,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Colors.grey.shade300,
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.search,
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 "Search anything",
//                                 style: TextStyle(color: Colors.grey.shade600),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         height: 55,
//                         width: 55,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Colors.black),
//                         child: Icon(
//                           Icons.filter_list,
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Consumer<CategoryController>(
//                   builder: (context, categoryObj, child) =>
//                       SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: List.generate(
//                         categoryObj.categorylist.length,
//                         (index) => Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 8),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.grey,
//                             ),
//                             height: 50,
//                             child: Center(
//                                 child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Text(
//                                 categoryObj.categorylist[index],
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             )),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Consumer<HomeScreenController>(
//                   builder: (context, providerobj, child) => Expanded(
//                     child: GridView.builder(
//                       itemCount: providerobj.shopModels?.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           childAspectRatio: .5 / .75,
//                           crossAxisSpacing: 5,
//                           mainAxisSpacing: 5),
//                       itemBuilder: (context, index) => Column(
//                         children: [
//                           Expanded(
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ProductScreen(),
//                                     ));
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(25),
//                                     image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(providerobj
//                                             .shopModels![index].image
//                                             .toString()))),
//                                 height: 300,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(14),
//                                   child: Stack(
//                                     alignment: Alignment.topRight,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           Container(
//                                               height: 40,
//                                               width: 40,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   color: Colors.grey.shade200),
//                                               child: Icon(Icons
//                                                   .favorite_border_outlined))
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.symmetric(horizontal: 10),
//                             child: Stack(
//                                 alignment: Alignment.bottomRight,
//                                 children: [
//                                   ListTile(
//                                     title: Text(
//                                       providerobj.shopModels![index].title
//                                           .toString(),
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12),
//                                     ),
//                                     subtitle: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "PKR ${providerobj.shopModels![index].price}",
//                                           style: TextStyle(
//                                             color: Colors.grey.shade700,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 10,
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Icon(Icons.star,
//                                                 color: Colors.amber, size: 12),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               "${providerobj.shopModels![index].rating!.rate.toString()} (${providerobj.shopModels![index].rating!.count.toString()} reviews)",
//                                               style: TextStyle(
//                                                 color: Colors.grey.shade600,
//                                                 fontSize: 10,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingcardui/controller/category_controller.dart';
import 'package:shoppingcardui/controller/home_controller.dart';
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
                          itemCount: providerObj.shopModels?.length ?? 0,
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductScreen(),
                                          ));
                                    },
                                    child: providerObj == true
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
