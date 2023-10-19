import 'package:flutter/material.dart';

class ItemCountProvider extends ChangeNotifier {
  int counter = 1;

  int get getCounter => counter;

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    if(counter > 0){
      counter--;
      notifyListeners();
    }
  }
}
