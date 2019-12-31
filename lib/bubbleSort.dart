

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
class MergeSort{
  final ValueController valueController;
  int n;
  MergeSort(this.valueController){
      this.n = valueController.numBars;
  }
  void sort() async{
    mergeSort(0, n-1);
  }
  Future mergeSort(int l,int r) async{
      if(r > l){
        int mid = l + ((r-l)/2).toInt();
        await mergeSort(l, mid);
        await wait(valueController.speed.toInt());
        await mergeSort(mid+1, r);
        await wait(valueController.speed.toInt());
        await merge(l,mid,r);
        await wait(valueController.speed.toInt());
      }
  }
  Future merge(int l,int m,int r) async{
    int n1 = m-l+1;
    int n2 = r-m;
    List<int> list1 = new List<int>(n1);
    List<int> list2 = new List<int>(n2);
    for(int i=0;i<n1;i++)   list1[i] = valueController.values[i+l];
    for(int i=0;i<n2;i++)   list2[i] = valueController.values[i+m+1];
    int i = 0,j=0,curr = l;
    while(i <n1 && j<n2){
        if(list1[i] < list2[j]){
          valueController.changeNotifiers[curr].value = 1;
          await wait(valueController.speed.toInt());        
          valueController.values[curr] =list1[i];
          valueController.valueNotifiers[curr].value =list1[i];
          await wait(valueController.speed.toInt());        
          valueController.changeNotifiers[curr].value = 0;
          i++; 
        }
        else{
          valueController.changeNotifiers[curr].value = 1;
          await wait(valueController.speed.toInt()); 
          valueController.values[curr] = list2[j];
          valueController.valueNotifiers[curr].value =list2[j];
          await wait(valueController.speed.toInt()); 
          valueController.changeNotifiers[curr].value = 0;
          j++;
        }
        curr++;
    }
    while(i < n1){
        valueController.values[curr] =list1[i];
        valueController.valueNotifiers[curr].value =list1[i];    
        i++;
        curr++;
        await wait(valueController.speed.toInt());
        }
    while(j < n2){
        valueController.values[curr] = list2[j];
        valueController.valueNotifiers[curr].value =valueController.values[curr];    
        curr++;
        j++;
        await wait(valueController.speed.toInt());
    }
  }
}

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


