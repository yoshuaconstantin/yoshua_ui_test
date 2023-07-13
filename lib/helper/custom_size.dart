import 'package:flutter/cupertino.dart';

class Cmdof{

  double custH(double number, BuildContext context){
    return MediaQuery.of(context).size.height * number;
  }

  double custW(double number, BuildContext context){
    return MediaQuery.of(context).size.width * number;
  }

  double H(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  double W(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
}