import 'package:flutter/material.dart';
import 'dart:math';
import 'wait.dart';

int numBars = 50;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    ValueController valueController = new ValueController(numBars);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BubbleSort Visualizer')
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 1000,
                height: 500,
                child: BarRow(valueController)
                ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: valueController.bubbleSort,
        ),
        ),
      );
  }
}

class BarRow extends StatelessWidget {
  final ValueController valueController;
  BarRow(this.valueController);

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: listValues.length,
    //   itemBuilder:(context,index) {        return Bar(listValues[index]);
    //   },
    // );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        for(int i=0;i<valueController.numBars;i++) ValueListenableBuilder(
          valueListenable: valueController.valueNotifiers[i],
          builder: (context,value,child){
            return Bar(valueController.valueNotifiers[i],valueController.changeNotifiers[i]);
          },
        )
      
      ],
    );
    
  }
}


class Bar extends StatefulWidget {
  double height;
  int isChanged;
  ValueNotifier<double> val;
  ValueNotifier<int>change;
  Color barColor = Colors.blue;
  Bar(this.val,this.change){
    // barColor = Colors.blue;
  }
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  Color findColor(int num){
    Color currColor = widget.change.value ==0 ? Colors.blue : Colors.black;
    if(widget.change.value ==2){
      currColor = Colors.green;
    }
    return currColor;
  }
  @override
  Widget build(BuildContext context) {
    Color currColor = Colors.blue;
    return ValueListenableBuilder(
      valueListenable: widget.change,
      builder: (context,value,child){ 
          return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: 2,
          height: widget.val.value*500,
          child: Container(
            color: findColor(value),
          ),
        )
        );
    }
    );
}
}

class ValueController {
  int numBars;
  List<double> values;
  List<ValueNotifier<double>> valueNotifiers;
  List<ValueNotifier<int>>changeNotifiers;
  ValueController(this.numBars){
    var randomNumberGenerator = new Random();
    values = new List<double>(numBars);
    changeNotifiers = new List<ValueNotifier<int>>(numBars);
    valueNotifiers = new List<ValueNotifier<double>> (numBars);
    for(int i=0;i<numBars;i++){
      values[i]  = randomNumberGenerator.nextDouble();
      valueNotifiers[i] = new ValueNotifier(values[i]);
      changeNotifiers[i] = new ValueNotifier(0);
    }
  }
  void swapValues(int index1,int index2) async{ //swap values in valueNotifiers
      // colorNotifiers[index1].value = Colors.yellow;
      // colorNotifiers[index2].value = Colors.purple;
      double tempVal = values[index1];
      values[index1] = values[index2];
      values[index2] = tempVal;
      valueNotifiers[index1].value = values[index1];
      valueNotifiers[index2].value = values[index2];
      // colorNotifiers[index1].value = Colors.blue;
      // colorNotifiers[index2].value = Colors.blue;
      // values[index1] = valueNotifiers[index1].value;
      // values[index2] = valueNotifiers[index2].value;
  }
  void bubbleSort() async{
    for(int i = 0;i<numBars;i++){
      for(int j=0;j<numBars-1;j++){
          if(values[j+1] < values[j]){
            changeNotifiers[j].value = 1;
            changeNotifiers[j+1].value = 1;
            swapValues(j+1,j);
            await wait();
            changeNotifiers[j].value = 0;
            changeNotifiers[j+1].value = 0;
            await wait();
            // print('swapped');
            // print(j);
            }
      }
        // print('changed color');
        // print(numBars-i-1);
        changeNotifiers[numBars-i-1].value = 2;
    }
  }
  // void selectionSort() async{
  //     for(int i=0;i<numBars;i++){
  //       int minIndex = i;
  //       for(int j = i;j<numBars;j++){
  //           if(valueNotifiers[j].value < valueNotifiers[minIndex].value){
  //             minIndex = j;
  //           }
  //       }
  //       swapValues(minIndex,i);
  //         await wait();
  //     }
  // }
  Future pause() async {
    await wait(speed: 0.5);
  }
}