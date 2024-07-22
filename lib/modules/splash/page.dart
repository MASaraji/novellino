import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/color_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => Get.offNamed('/home'));
  }

  RichText textLogo() {
    return RichText(
      text: const TextSpan(
          style: TextStyle(
              color: Colors.black, fontSize: 60, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: "NOVEL\n",
            ),
            TextSpan(
              text: "LINO",
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: mabBackgroundColor,
        child: textLogo());
  }
}
