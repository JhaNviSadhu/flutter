import 'package:flutter/material.dart';
import '../../settings/settings.dart';

class ItemDescription extends StatefulWidget {
  static const routeName = "/item-description";
  @override
  _ItemDescriptionState createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  double paddingImage = 50;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        paddingImage = 0;
      });
    });
    final List<dynamic> arguments = ModalRoute.of(context).settings.arguments;
    final itemName = arguments[0];
    final itemPrice = arguments[1];
    final itemURL = arguments[2];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.card_travel), onPressed: () {}),
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {})
        ],
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      padding: EdgeInsets.all(paddingImage),
                      child: Image.network(itemURL),
                      duration: Duration(milliseconds: 600),
                      onEnd: () {},
                    ),
                    flex: 2,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weight',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        '500g',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text('Calories', style: TextStyle(fontSize: 19)),
                      Text(
                        '650cal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text('person', style: TextStyle(fontSize: 19)),
                      Text(
                        '1 person',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ))
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$' + itemPrice.toStringAsFixed(2),
                    style:
                        TextStyle(fontSize: 20, color: MainColors.greencolor),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Delicious red apple, keep it in the refrigirator and eat it before one week',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'This appleis from the local cultivator of fruit',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              flex: 1,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
          color: MainColors.greencolor,
          child: Text(
            'Add To Card',
            style: TextStyle(color: MainColors.whitecolor),
          ),
        ),
      ),
    );
  }
}
