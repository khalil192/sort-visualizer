


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'wait.dart';

class ValueController {
  int numBars;
  List<int> values;
  double speed;
  double maxHeight;
  List<ValueNotifier<int>> valueNotifiers;
  List<ValueNotifier<int>>changeNotifiers;
  ValueController(this.numBars,this.speed,this.maxHeight){
    var randomNumberGenerator = new Random();
    values = new List<int>(numBars);
    changeNotifiers = new List<ValueNotifier<int>>(numBars);
    valueNotifiers = new List<ValueNotifier<int>> (numBars);
    for(int i=0;i<numBars;i++){
      values[i]  = ((randomNumberGenerator.nextDouble() * 100 ).toInt()) % maxHeight.toInt();
      valueNotifiers[i] = new ValueNotifier(values[i]);
      changeNotifiers[i] = new ValueNotifier(0);
    }
  }
  void swapValues(int index1,int index2) async{ //swap values in valueNotifiers
      // colorNotifiers[index2].value = Colors.purple;
      int tempVal = values[index1];
      values[index1] = values[index2];
      values[index2] = tempVal;
      valueNotifiers[index1].value = values[index1];
      valueNotifiers[index2].value = values[index2];
  }
  }