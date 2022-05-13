import 'package:flutter/material.dart';
import 'package:happy_messanger/app/common/text_style.dart';

class HolydayView extends StatelessWidget {
  HolydayView({Key? key}) : super(key: key);

  final holiday = [
    {
      'NEW YEAR',
      '\$3.99',
      'assets/images/dash1.png',
      false,
      false,
    },
    {
      'EASTER',
      '\$5.99',
      'assets/images/dash1.png',
      true,
      false,
    },
    {
      'CHRISMAS',
      '\$2.99',
      'assets/images/dash1.png',
      false,
      false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15.0),
      width: MediaQuery.of(context).size.width - 30.0,
      height: MediaQuery.of(context).size.height - 50.0,
      child: GridView.count(
        crossAxisCount: 2,
        primary: false,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.8,
        children: <Widget>[
          _buildCard('NEW YEAR', '\$3.99', 'assets/images/dash1.png', false,
              false, context),
          _buildCard('EASTER', '\$5.99', 'assets/images/dash1.png', true, false,
              context),
          _buildCard('EPIPHANY', '\$1.99', 'assets/images/dash1.png', false,
              true, context),
          _buildCard('CHRISMAS', '\$2.99', 'assets/images/dash1.png', false,
              false, context),
          _buildCard('MESKEL', '\$1.99', 'assets/images/dash1.png', false, true,
              context),
          _buildCard('ED-ALFATIR', '\$2.99', 'assets/images/dash1.png', false,
              false, context),
          _buildCard('AREFA', '\$2.99', 'assets/images/dash1.png', false, false,
              context),
          _buildCard('bUHIE', '\$2.99', 'assets/images/dash1.png', false, false,
              context),
          _buildCard('MEWLID', '\$2.99', 'assets/images/dash1.png', false,
              false, context)
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => CookieDetail(
          //         assetPath: imgPath, cookieprice: price, cookiename: name)));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    isFavorite
                        ? const Icon(Icons.favorite, color: Color(0xFFEF7532))
                        : const Icon(Icons.favorite_border,
                            color: Color(0xFFEF7532))
                  ])),
              Hero(
                  tag: name,
                  child: Container(
                      height: 75.0,
                      width: 75.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(imgPath),
                              fit: BoxFit.contain)))),
              const SizedBox(height: 7.0),
              Text(price,
                  style: const TextStyle(
                      color: Color(0xFFCC8053),
                      fontFamily: 'Varela',
                      fontSize: 14.0)),
              Text(name, style: textStyle22),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Container(color: const Color(0xFFEBEBEB), height: 1.0)),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!added) ...[
                      const Icon(Icons.shopping_basket,
                          color: Color(0xFFD17E50), size: 12.0),
                      const Text('Add to cart',
                          style: TextStyle(
                              fontFamily: 'Varela',
                              color: Color(0xFFD17E50),
                              fontSize: 12.0))
                    ],
                    if (added) ...[
                      const Icon(Icons.remove_circle_outline,
                          color: Color(0xFFD17E50), size: 12.0),
                      const Text('3',
                          style: TextStyle(
                              fontFamily: 'Varela',
                              color: Color(0xFFD17E50),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0)),
                      const Icon(Icons.add_circle_outline,
                          color: Color(0xFFD17E50), size: 12.0),
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
