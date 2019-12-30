import 'package:flutter/material.dart';
import 'dart:math';
import 'wait.dart';

int numBars = 30;

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        for(int i=0;i<valueController.numBars;i++) ValueListenableBuilder(
          valueListenable: valueController.colorNotifiers[i],
          builder: (context,value,child){
            return Bar(valueController.values[i], value);
          },
        )
      
      ],
    );
    
  }
}


class Bar extends StatefulWidget {
  double height;
  double indi;
  Color barColor = Colors.blue;
  Bar(this.height,this.barColor){
    barColor = Colors.blue;
  }
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    Color currColor = Colors.blue;
    currColor = widget.barColor;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 10,
        height: widget.height*500,
        child: Container(
          color: currColor,
        ),
      ),
    );
  }
}


class ValueController {
  int numBars;
  List<double> values;
  // List<ValueNotifier<double>> valueNotifiers;
  List<ValueNotifier<Color>>colorNotifiers;
  ValueController(this.numBars){
    var randomNumberGenerator = new Random();
    values = new List<double>(numBars);
    colorNotifiers = new List<ValueNotifier<Color>>(numBars);
    // valueNotifiers = new List<ValueNotifier<double>> (numBars);
    for(int i=0;i<numBars;i++){
      values[i]  = randomNumberGenerator.nextDouble();
      // valueNotifiers[i] = new ValueNotifier(values[i]);
      colorNotifiers[i] = new ValueNotifier(Colors.blue);
    }
  }
  void swapValues(int index1,int index2) async{ //swap values in valueNotifiers
      colorNotifiers[index1].value = Colors.yellow;
      colorNotifiers[index2].value = Colors.purple;
      await wait();
      double tempVal = values[index1];
      values[index1] = values[index2];
      values[index2] = tempVal;
      colorNotifiers[index1].value = Colors.blue;
      colorNotifiers[index2].value = Colors.blue;
      // values[index1] = valueNotifiers[index1].value;
      // values[index2] = valueNotifiers[index2].value;
  }
  void bubbleSort() async{
    for(int i = 0;i<numBars;i++){
      for(int j=0;j<numBars-1;j++){
          if(values[j+1] > values[j]){
            swapValues(j+1,j);
            }
          // valueNotifiers[]
      }
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