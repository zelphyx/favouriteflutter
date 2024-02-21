import 'package:flutter/material.dart';
import 'package:tugas_feature/FavouritePage.dart';
import 'package:tugas_feature/listtest.dart';

class BreezeDark {
  static const carddark = Colors.blue; // Replace with your color
}

class IconTextButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final bool isSelected;


  const IconTextButton({
    this.icon,
    required this.text,
    this.isSelected = false,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? BreezeDark.carddark.withOpacity(0.5) : null,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          if (icon != null) Icon(icon),
          SizedBox(width: icon != null ? 12 : 0),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),

        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BreezeDark.carddark,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      width: 300,
      child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  ListPage()),);},
                child: IconTextButton( text: "AnimePedia")),
            GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  ListPage()),);},
                child: IconTextButton(icon:Icons.category, text: "All Data")),
            GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  FavPage()),);},
                child: IconTextButton(icon: Icons.star, text: "Your Favourite"))
            // Add more IconTextButtons as needed
          ],
        ),
      );

  }
}
