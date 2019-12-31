

import 'package:sort/valueController.dart';
import 'package:sort/wait.dart';

class BubbleSort{
  final ValueController valueController;
  int numBars;
  BubbleSort(this.valueController){
    numBars = valueController.numBars;
  }
   void sort() async{
    for(int i = 0;i<numBars;i++){
      for(int j=0;j<numBars-1;j++){
          if(valueController.values[j+1] < valueController.values[j]){
            valueController.changeNotifiers[j].value = 1;
            valueController.changeNotifiers[j+1].value = 1;
            valueController.swapValues(j+1,j);
            await wait(valueController.speed.toInt());
            valueController.changeNotifiers[j].value = 0;
            valueController.changeNotifiers[j+1].value = 0;
            await wait(valueController.speed.toInt());
            }
      }
        valueController.changeNotifiers[numBars-i-1].value = 2;
    }
  }
}
class SelectionSort{
  final ValueController valueController;
  SelectionSort(this.valueController);
 void sort() async{
      for(int i=0;i<valueController.numBars;i++){
        int minIndex = i;
        for(int j = i;j<valueController.numBars;j++){
            if(valueController.valueNotifiers[j].value < valueController.valueNotifiers[minIndex].value){
              minIndex = j;
            
            }
        }
              valueController.changeNotifiers[minIndex].value = 1;
              valueController.changeNotifiers[i].value = 1;
              valueController.swapValues(minIndex,i);
              await wait(valueController.speed.toInt());
              valueController.changeNotifiers[minIndex].value = 0;
              valueController.changeNotifiers[i].value = 2;
              await wait(valueController.speed.toInt());
      }
  }
}