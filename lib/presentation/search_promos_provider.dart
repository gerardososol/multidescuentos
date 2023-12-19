import 'package:flutter/material.dart';

import '../classes/Promo.dart';

class SearchPromosProvider extends ChangeNotifier{
  Promo? promo;

  Future<void> viewItem(Promo promo) async{
    this.promo = promo;
  }
}