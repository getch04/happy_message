import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_messanger/app/common/text_style.dart';
import 'package:happy_messanger/app/modules/messageDetail/views/message_detail_view.dart';

class BirthdayView extends StatelessWidget {
  const BirthdayView({Key? key}) : super(key: key);

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
          _buildCard('NEW YEAR', 'Sep, 1', 'assets/images/hyear.png',
              'Wish Happy New Year', false, context),
          _buildCard('EASTER', '\$5.99', 'assets/images/easter.png',
              'Wish Happy EASTER', false, context),
          _buildCard('EPIPHANY', 'Jan,11', 'assets/images/epiphany.png',
              'Wish Happy EPIPHANY', true, context),
          _buildCard('CHRISMAS', '\$2.99', 'assets/images/christ.png',
              'Wish Happy CHRISMAS', false, context),
          _buildCard('MESKEL', '\$1.99', 'assets/images/cross.png',
              'Wish Happy MESKEL', true, context),
          _buildCard('BUHIE', '\$2.99', 'assets/images/bread.png',
              'Wish Happy BUHIE', false, context),
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, String wish,
      bool isFavorite, context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MessageDetailView(
                  assetPath: imgPath, price: price, name: name),
            ),
          );
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isFavorite
                        ? const Icon(Icons.favorite, color: Color(0xFFEF7532))
                        : const Icon(Icons.favorite_border,
                            color: Color(0xFFEF7532))
                  ],
                ),
              ),
              Hero(
                tag: name,
                child: Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imgPath), fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 7.0),
              Text(
                price,
                style: GoogleFonts.varelaRound(
                    color: const Color(0xFFCC8053), fontSize: 14.0),
              ),
              Text(
                name,
                style: textStyle18,
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Container(color: const Color(0xFFEBEBEB), height: 1.0)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.shopping_basket,
                          color: Color(0xFFD17E50), size: 12.0),
                      Expanded(
                          child: Text(
                        wish,
                        style: textStyle16,
                        textAlign: TextAlign.center,
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
