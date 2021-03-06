import 'package:flutter/material.dart';
import 'bubbleSort.dart';
import 'valueController.dart';
import 'dart:math';
import 'mergeSort.dart';
import 'quickSort.dart';
import 'radixSort.dart';
import 'selectionSort.dart';
import 'wait.dart';
import 'RevSelectionSort.dart';

double numBars = 50;
double barWidth = 2;
double speed = 240;
double containerWidth;
String sortMethod = "bubble sort";
void main() {
  runApp(App());
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sort Visualizer',
      theme: ThemeData( primarySwatch: Colors.indigo,),
      home: MyApp(),
    );
  }
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ValueController valueController;
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
      case "radix sort" :{
        RadixSort radixSort = new RadixSort(valueController);
        radixSort.sort();
      }
      break;
    }
  }
   reverseData(){
     RevSelectionSort revSelectionSort = new RevSelectionSort(valueController);
     revSelectionSort.sort();
  }
  @override
  Widget build(BuildContext context){
    // int numBars = 20;
    valueController = new ValueController(numBars.toInt(),speed,MediaQuery.of(context).size.height *0.7);
    return  Scaffold(
        appBar: AppBar(
          title: Text('Sort Visualizer'),
          actions: <Widget>[
            Row(
              children: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side : BorderSide(color: Colors.white)
                    ),
                    onPressed: ()=>{
                      // setState(() {
                      reverseData(),
                      // }
                      // )
                      },
                      child: Text("reverse data"),
                  ),
                  SizedBox(width: 10,),
                 DropdownButton<String>(
                          value: sortMethod,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.black
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
                          items: <String>['bubble sort', 'selection sort', 'merge sort', 'quick sort','radix sort']
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
                            max: 600,
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
                            max: 600,
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
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
        body: Center(
          child: Container(
                    width: MediaQuery.of(context).size.width*0.98,
                    height: MediaQuery.of(context).size.height,
                    child: BarRow(valueController)
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('sort'),
          onPressed: () => sortStartVisualize(valueController) ,
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
        padding: const EdgeInsets.all(0.0125),
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
