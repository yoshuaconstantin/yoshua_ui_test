
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBarWithSecondTitle extends StatelessWidget implements PreferredSizeWidget{
  final Function() arrowBackTapped;
  final String title;
  final String title2;
  final Color? statusBarColor, backgroundColor;
  final String? bgImage;
  final List<Widget>? actions;

  const CustomAppBarWithSecondTitle({
    Key? key,
    required this.title,
    required this.title2,
    required this.arrowBackTapped,
    // this.statusBarColor = const Color(0x00000000),
    // this.backgroundColor = const Color(0xFFFFFFFF),
    this.statusBarColor,
    this.backgroundColor = null,
    this.bgImage,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bgImage != null ?
            Image.asset(bgImage!)
            :
            SizedBox(),
        AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: statusBarColor),
          backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title),
              SizedBox(height: 3,),
              Text(title2, style: TextStyle(fontSize: 14),)
            ],
          ),
          titleTextStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Asap'),
          leading: IconButton(onPressed: arrowBackTapped, icon: const Icon(Icons.arrow_back)),
          iconTheme: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFFFFFFF) : Color(0xFF323232)),
          titleSpacing: 0,
          elevation: 0,
          actions: actions,
        ),
      ],
    );
  }
}