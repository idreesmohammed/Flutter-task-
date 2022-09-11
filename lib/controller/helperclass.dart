import 'package:flutter/material.dart';

class Helper extends ChangeNotifier {
  var storedArray;
  var _id;
  changeRadioButtonColor(radioButtonColor, radioButtonColor2) {
    radioButtonColor = true;
    radioButtonColor2 = false;
    notifyListeners();
  }

  functionForStoring(arrayOfData, id) async {
    arrayOfData = await storedArray;
    notifyListeners();
    id = await _id;
    notifyListeners();
  }
}
