import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcardui/controller/controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeScreenController>().getStore();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              Icon(
                Icons.notifications_active_outlined,
                color: Colors.black,
                size: 35,
              ),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.black,
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Search anything",
                          style: TextStyle(color: Colors.grey.shade600),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black),
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: Text(
                  "All",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  child: Text(
                    "Men",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  child: Text(
                    "Women",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  child: Text(
                    "Kids",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Consumer<HomeScreenController>(
            builder: (context, providerobj, child) => Expanded(
              child: GridView.builder(
                itemCount: providerobj.shopModels?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .5 / .75,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (context, index) => Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(providerobj
                                    .shopModels![index].image
                                    .toString()))),
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade200),
                                      child:
                                          Icon(Icons.favorite_border_outlined))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        ListTile(
                          title: Text(
                            providerobj.shopModels![index].title.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                providerobj.shopModels![index].description
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                "PKR ${providerobj.shopModels![index].price}",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 12),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${providerobj.shopModels![index].rating!.rate.toString()} (${providerobj.shopModels![index].rating!.count.toString()} reviews)",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
