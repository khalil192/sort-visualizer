


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:sort/wait.dart';

class ValueController {
  int numBars;
  List<int> values;
  double speed;
  List<ValueNotifier<int>> valueNotifiers;
  List<ValueNotifier<int>>changeNotifiers;
  ValueController(this.numBars,this.speed){
    var randomNumberGenerator = new Random();
    values = new List<int>(numBars);
    changeNotifiers = new List<ValueNotifier<int>>(numBars);
    valueNotifiers = new List<ValueNotifier<int>> (numBars);
    for(int i=0;i<numBars;i++){
      values[i]  = (randomNumberGenerator.nextDouble() * 100 ).toInt();
      valueNotifiers[i] = new ValueNotifier(values[i]);
      changeNotifiers[i] = new ValueNotifier(0);
    }
  }
  void swapValues(int index1,int index2) async{ //swap values in valueNotifiers
      // colorNotifiers[index1].value = Colors.yellow;
      // colorNotifiers[index2].value = Colors.purple;
      int tempVal = values[index1];
      values[index1] = values[index2];
      values[index2] = tempVal;
      valueNotifiers[index1].value = values[index1];
      valueNotifiers[index2].value = values[index2];
      // colorNotifiers[index1].value = Colors.blue;
      // colorNotifiers[index2].value = Colors.blue;
      // values[index1] = valueNotifiers[index1].value;
      // values[index2] = valueNotifiers[index2].value;
  }
  // void bubbleSort() async{
  //   for(int i = 0;i<numBars;i++){
  //     for(int j=0;j<numBars-1;j++){
  //         if(values[j+1] < values[j]){
  //           changeNotifiers[j].value = 1;
  //           changeNotifiers[j+1].value = 1;
  //           swapValues(j+1,j);
  //           await wait(speed.toInt());
  //           changeNotifiers[j].value = 0;
  //           changeNotifiers[j+1].value = 0;
  //           await wait(speed.toInt());
  //           }
  //     }
  //       changeNotifiers[numBars-i-1].value = 2;
  //   }
  // }
  // void selectionSort() async{
  //     for(int i=0;i<numBars;i++){
  //       int minIndex = i;
  //       for(int j = i;j<numBars;j++){
  //           if(valueNotifiers[j].value < valueNotifiers[minIndex].value){
  //             minIndex = j;
            
  //           }
  //       }
  //             changeNotifiers[minIndex].value = 1;
  //             changeNotifiers[i].value = 1;
  //             swapValues(minIndex,i);
  //             await wait(speed.toInt());
  //             changeNotifiers[minIndex].value = 0;
  //             changeNotifiers[i].value = 2;
  //             await wait(speed.toInt());
  //     }
  // }
  // Future pause() async {
  //   await wait(speed: 0.5);
  // }
}