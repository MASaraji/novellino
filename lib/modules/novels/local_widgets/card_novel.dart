import "package:flutter/material.dart";
import "package:auto_size_text/auto_size_text.dart";

class CardNovel extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTapFunc;
  const CardNovel(
      {Key? key, required this.title, this.image = "", required this.onTapFunc})
      : super(key: key);

//---------------------------------------------------------------------------------------

  Widget backgroundCover(String image) =>
      Image.network(image, fit: BoxFit.fill);

  Widget innerShadow() => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54])));

  Widget cardTitle(String title) => AutoSizeText(title,
      style: const TextStyle(
          fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white));

//------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunc,
      child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Stack(children: [
                Positioned.fill(child: backgroundCover(image)),
                Positioned.fill(child: innerShadow()),
                Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    right: 10.0,
                    child: cardTitle(title))
              ]))),
    );
  }
}
