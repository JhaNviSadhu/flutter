import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:naman/Screens/home/image_silder.dart';
import 'package:provider/provider.dart';
import '../../settings/settings.dart';
import 'item_description.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemListWidget extends StatefulWidget {
  final User user;
  final List<String> currentFav;
  ItemListWidget({@required this.user, @required this.currentFav});
  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  int currPage;
  List<String> itemName = [
    'Apple',
    'Orange',
    'Milk',
    'Cheese',
  ];

  List<double> itemPrice = [
    1.00,
    1.10,
    4.25,
    8.25,
  ];

  List<String> itemURLImageSilder = [
    'https://www.sandiegorestaurantweek.com/wp-content/uploads/2018/09/iStock-687758388.jpg',
    'https://i.ndtvimg.com/i/2017-01/biryani_620x350_41483682476.jpg',
    'https://media1.popsugar-assets.com/files/thumbor/VE38SVpDoRg4ebLYMoAwwZBEDzU/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2017/09/13/724/n/1922195/b749a7f659b95b87259fe2.90319095_edit_img_image_44014696_1505318995/i/Foods-Taste-Good-Cold.jpg',
    'http://www.esprevmed.org/wp-content/uploads/2016/02/sweets.jpg',
  ];

  List<String> itemURLImageSilder3 = [
    'http://www.esprevmed.org/wp-content/uploads/2016/02/sweets.jpg',
    'https://i.ndtvimg.com/i/2017-01/biryani_620x350_41483682476.jpg',
    'https://media1.popsugar-assets.com/files/thumbor/VE38SVpDoRg4ebLYMoAwwZBEDzU/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2017/09/13/724/n/1922195/b749a7f659b95b87259fe2.90319095_edit_img_image_44014696_1505318995/i/Foods-Taste-Good-Cold.jpg',
    'http://www.esprevmed.org/wp-content/uploads/2016/02/sweets.jpg',
  ];

  List<String> itemURLImage = [
    'https://www.seekpng.com/png/full/932-9328492_apple-png-free-image-download-apfel-bild.png',
    'https://cdn.pixabay.com/photo/2016/02/23/17/42/orange-1218158_960_720.png',
    'https://images.vexels.com/media/users/3/160371/isolated/preview/6c40e6ebea6870c673bc72d8f215724d-milk-box-milk-cow-illustration-by-vexels.png',
    'http://www.pngplay.com/wp-content/uploads/1/Cheese-PNG-Image.png',
  ];

  favorites(itemName) async {
    await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(widget.user.uid)
        .get()
        .then((favorites) async {
      if (favorites.data().containsKey(itemName)) {
        await FirebaseFirestore.instance
            .collection('Favorites')
            .doc(widget.user.uid)
            .update({itemName: FieldValue.delete()}).then((_) {
          setState(() {
            currentFavorites.remove(itemName);
          });
        });
      } else {
        await FirebaseFirestore.instance
            .collection('Favorites')
            .doc(widget.user.uid)
            .update({itemName: itemName}).then((_) {
          setState(() {
            currentFavorites.add(itemName);
          });
        });
      }
      print(currentFavorites);
    });
  }

  List<String> currentFavorites = [];
  bool intCurrent = true;

  @override
  Widget build(BuildContext context) {
    if (intCurrent) {
      setState(() {
        currPage = 0;
        currentFavorites = widget.currentFav;
        intCurrent = false;
      });
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            actions: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Restorent...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                color: MainColors.whitecolor,
              )
            ],
          ),
          Stack(
            children: [
              Container(
                height: 220,
                child: PageView.builder(
                  onPageChanged: (int currentPage) {
                    currPage = currentPage;
                    Provider.of<ImageSilder>(context, listen: false)
                        .actualPage(currPage);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Image.network(
                        itemURLImageSilder[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  itemCount: itemURLImageSilder.length,
                ),
              ),
              Consumer<ImageSilder>(builder: (context, imageSilder, widget) {
                return imageSilder.getDotsWidget(currPage);
              })
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 14, top: 14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Most Popular',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 200,
                  child: CustomScrollView(
                    scrollDirection: Axis.horizontal,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Row(
                              children: List.generate(
                                4,
                                (index) {
                                  return Container(
                                    padding: EdgeInsets.all(6),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 150,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              itemURLImageSilder[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          height: 80,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: MainColors.whitecolor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  'Dessert Inc',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  '9:00AM to 10:00PM',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  '2233 road avenue',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Canadian Food',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: CustomScrollView(
                    scrollDirection: Axis.horizontal,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Row(
                              children: List.generate(
                                4,
                                (index) {
                                  return Container(
                                    padding: EdgeInsets.all(6),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 150,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              itemURLImageSilder3[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  'Dessert Inc',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.5),
                                                    color:
                                                        MainColors.whitecolor,
                                                  ),
                                                ),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  '9:00AM to 10:00PM',
                                                  style: TextStyle(
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.5),
                                                    color:
                                                        MainColors.whitecolor,
                                                  ),
                                                ),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  '2233 road avenue',
                                                  style: TextStyle(
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.5),
                                                    color:
                                                        MainColors.whitecolor,
                                                  ),
                                                ),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(
                    itemName.length,
                    (index) => LayoutBuilder(
                      builder: (context, constrains) {
                        return Row(
                          children: [
                            Container(
                              width: constrains.maxWidth / 6 * 5,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ItemDescription.routeName,
                                      arguments: [
                                        itemName[index],
                                        itemPrice[index],
                                        itemURLImage[index],
                                      ]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: MainColors.whitecolor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: CircleAvatar(
                                          radius: 35,
                                          child: Image.network(
                                              itemURLImage[index]),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemName[index],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.orangeAccent,
                                                ),
                                                Text(
                                                  '4.5  ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '  Grocery food',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.grey
                                                    .withOpacity(0.3)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.monetization_on,
                                                  color: Colors.grey,
                                                ),
                                                Text(itemPrice[index]
                                                        .toStringAsFixed(2) +
                                                    '\$'),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: constrains.maxWidth / 6,
                              child: IconButton(
                                icon: Icon(
                                  currentFavorites.contains(itemName[index])
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  favorites(itemName[index]);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
