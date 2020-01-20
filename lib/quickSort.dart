
import 'valueController.dart';
import 'wait.dart';

class QuickSort{
  final ValueController valueController;
  int n;
  QuickSort(this.valueController){
    n = valueController.numBars;
  }
  void sort() async{
      quickSort(0, n-1);
  }
  Future quickSort(int l,int r) async{
    if(l < r){
      int partitionindex = await partition(l,r);
      await wait(valueController.speed.toInt());        
      await quickSort(l, partitionindex-1);
      await wait(valueController.speed.toInt());        
      await quickSort(partitionindex+1, r);
      await wait(valueController.speed.toInt());        
    }
    else if(l==r){
    valueController.changeNotifiers[l].value = 2;
    }
  }
  Future<int> partition(int l,int r) async{
    int pivotElement = valueController.values[r];
    int i = l- 1;
    for(int j = l;j<r;j++){
      if(valueController.values[j] < pivotElement){
        i++;
        valueController.changeNotifiers[j].value = 1;
        valueController.changeNotifiers[j+1].value = 1;
        await wait(valueController.speed.toInt());        
        valueController.swapValues(i, j);
        valueController.changeNotifiers[j].value = 0;
        valueController.changeNotifiers[j+1].value = 0;
        await wait(valueController.speed.toInt());        
      }
    }
        valueController.changeNotifiers[i+1].value = 1;
        valueController.changeNotifiers[r].value = 1;
        await wait(valueController.speed.toInt());        
        valueController.swapValues(i+1, r);
        valueController.changeNotifiers[i+1].value = 0;
        valueController.changeNotifiers[r].value = 0;
        await wait(valueController.speed.toInt());  
        valueController.changeNotifiers[i+1].value = 2;
    return Future.value(i+1);
  }
}