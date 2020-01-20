import 'valueController.dart';
import 'wait.dart';

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
