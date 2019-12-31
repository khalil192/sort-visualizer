import 'package:flutter/material.dart';
import 'package:sort/bubbleSort.dart';
import 'package:sort/valueController.dart';
import 'dart:math';
import 'wait.dart';

double numBars = 30;
double barWidth = 5;
double speed = 90;
String sortMethod = "bubble sort";
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void sortStartVisualize(ValueController valueController){
    switch(sortMethod){
      case "bubble sort" : {
      BubbleSort bubbleSort = new BubbleSort(valueController);
      bubbleSort.sort();
      }
      break;
      case "selection sort" :{
        SelectionSort selectionSort = new SelectionSort(valueController);
        selectionSort.sort();
      }
      break;
      case "merge sort" :{
        MergeSort mergeSort = new MergeSort(valueController);
        mergeSort.sort();
      }
      break;
      case "quick sort" :{
        QuickSort quickSort = new QuickSort(valueController);
        quickSort.sort();
      }
      break;
    }
      
  }

  @override
  Widget build(BuildContext context){
    // int numBars = 20;
    ValueController valueController = new ValueController(numBars.toInt(),speed);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sort Visualizer'),
          actions: <Widget>[
            Row(
              children: <Widget>[
                 DropdownButton<String>(
                          value: sortMethod,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.deepPurple
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              sortMethod = newValue;
                            });
                          },
                          items: <String>['bubble sort', 'selection sort', 'merge sort', 'quick sort']
                            .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                            .toList(),
                        ),
                      Container(
                        width: 300,
                        height: 50,
                        child: Column(
                          children: <Widget>[
                      Container(
                        width: 300,
                        height: 20,
                        child: Slider(
                            min: 5.0,
                            max: 100,
                            activeColor: Colors.black,
                            inactiveColor: Colors.pink,
                            value: numBars,
                            onChanged: (newRating){
                              setState(() {
                                numBars = newRating;
                              });
                          },
                    ),

                      ),
                      Text(
                              'data size',
                              style: TextStyle(
                                color: Colors.blue[1000],
                                fontSize: 20
                              ),
                            ), 
                          ],
                        ),
                        ),
                     
                 Container(
                        width: 300,
                        height: 50,
                        child: Column(
                          children: <Widget>[
                      Container(
                        width: 300,
                        height: 20,
                        child: Slider(
                            min: 5.0,
                            max: 120,
                            activeColor: Colors.black,
                            inactiveColor: Colors.pink,
                            value: speed,
                            onChanged: (newRating){
                              setState(() {
                                speed = newRating;
                              });
                          },
                    ),

                      ),
                      Text(
                              'speed',
                              style: TextStyle(
                                color: Colors.blue[1000],
                                fontSize: 20
                              ),
                            ), 
                          ],
                        ),
                        ),
            ],)
          ],
        ),
        body: SafeArea(
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
          child: Text('sort'),
          onPressed: () => sortStartVisualize(valueController) ,
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
  ValueNotifier<int> val;
  ValueNotifier<int>change;
  Color barColor = Colors.blue;
  Bar(this.val,this.change){
    // height = val.value.toDouble();
  }
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  Color findColor(int num){
    Color currColor = widget.change.value ==0 ? Colors.blue: Colors.purple;
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
        padding: const EdgeInsets.all(2.0),
        child: SizedBox(
          width: barWidth,
          height: widget.val.value.toDouble()*5,
          child: Container(
            color: findColor(value),
          ),
        )
        );
    }
    );
}
}
