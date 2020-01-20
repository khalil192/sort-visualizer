
import 'dart:collection';

import 'valueController.dart';
import 'wait.dart';

class RadixSort{
  ValueController valueController;
  int n,divi;
  int radixBase;
  List<Queue> ques;
  RadixSort(this.valueController){
    n = valueController.numBars;
    radixBase = 10;
    divi = 10;
  }
 void sort() async {
    ques =  new List<Queue>(radixBase);
    for(int i=0;i<radixBase;i++) ques[i] = new Queue();
     await radixSort();
    for(int i=0;i<n;i++){
        await wait(valueController.speed.toInt());  
          valueController.changeNotifiers[i].value = 2;
      }
  }
  Future doQueueOp() async {
    for(int i=0;i<radixBase;i++) ques[i] = new Queue();
      for(int i=0;i<n;i++){
        int index = (valueController.values[i] ~/ divi)% radixBase;
        // print(index);
        ques[index].add(valueController.values[i]);
      }
      int index = 0;
      for(int curr = 0;curr<radixBase;curr++){
        while(ques[curr].isNotEmpty){
          int num = ques[curr].removeFirst();
          valueController.values[index] = num;
          valueController.valueNotifiers[index].value = num;
          await wait(valueController.speed.toInt());        
          valueController.changeNotifiers[index].value = 1;
          await wait(valueController.speed.toInt());        
          valueController.changeNotifiers[index++].value = 0;
        }
      }
  }
  void radixSort() async{
      int maxi = valueController.values[0];
      for(int i=1;i<n;i++){
        if(valueController.values[i] > maxi){
            maxi = valueController.values[i];
        }
      }
      divi = 1;
      while(true){
        await wait(valueController.speed.toInt());              
        await doQueueOp();
        await wait(valueController.speed.toInt());        
        if(divi > maxi){
          break;
        }
        divi *= radixBase;
      }
  }
}
