import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:novellino/modules/sites/controller.dart';
import '../../../data/model/model.dart';

class CardSite extends StatelessWidget {
  final String title;
  late final siteController = Get.find<SiteController>();
  late final dynamic site = siteController.getSiteArg(title);
  late final Logo logo = site.logo;
  final VoidCallback onTapFunc;
  final VoidCallback? onLongPressFunc;
  CardSite(
      {Key? key,
      required this.title,
      required this.onTapFunc,
      this.onLongPressFunc})
      : super(key: key);

//---------------------------------------------------------------------------------------------

  Widget backgroundCover(Logo logo) => ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: logo.address != ""
          ? Image.network(
              logo.address,
              fit: BoxFit.fill,
            )
          : Center(
              child: Text(title,
                  style: TextStyle(
                      color: logo.colorText,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ));

//-------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: onLongPressFunc,
        onTap: onTapFunc,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                side:
                    BorderSide(color: Colors.black.withOpacity(.2), width: 2)),
            elevation: 10,
            surfaceTintColor: Colors.white,
            color: logo.color,
            margin: const EdgeInsets.all(10),
            child: Stack(
                children: [Positioned.fill(child: backgroundCover(logo))])));
  }
}
