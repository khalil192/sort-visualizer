import 'valueController.dart';
import 'wait.dart';

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