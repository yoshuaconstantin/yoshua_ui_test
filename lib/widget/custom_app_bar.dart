import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() arrowBackTapped;
  final String title;
  final String subtitle;
  final Color? statusBarColor, backgroundColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? height;
  final Widget? flexibleSpace;
  final String? bgImage;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.subtitle = "",
    required this.arrowBackTapped,
    // this.statusBarColor = const Color(0x00000000),
    // this.backgroundColor = const Color(0xFFFFFFFF),
    this.statusBarColor,
    this.backgroundColor = null,
    this.bottom,
    this.actions,
    this.height,
    this.flexibleSpace,
    this.bgImage
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: statusBarColor),
      backgroundColor: Colors.transparent,
      title: Text(title),
      centerTitle: true,
      titleTextStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Asap'),
      leading: IconButton(onPressed: arrowBackTapped, icon: const Icon(Icons.arrow_back)),
      iconTheme: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
      bottom: bottom,
      titleSpacing: 0,
      elevation: 0,
      actions: actions,
      flexibleSpace: flexibleSpace,

    );
  }
}