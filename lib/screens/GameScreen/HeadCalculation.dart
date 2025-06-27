import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../../constants/app_text_style.dart';

class HeadCalculation extends StatefulWidget {

  HeadCalculation({super.key}) : super();

  @override
  _HeadCalculationState createState() => _HeadCalculationState();
}

var random = Random();

// min inclusive, max exclusive
int randomInt(int min, int max) {
  return min + random.nextInt(max - min);
}

class _HeadCalculationState extends State<HeadCalculation> {
  _HeadCalculationState() {
    _generateTask();
  }

  var _task = '';
  var _score = 0;
  var _rightResult;
  var _inputController = TextEditingController();
  var _wasFalse = false;
  var _wasRight = false;

  void _generateTask() {
    var type = random.nextInt(4);
    switch (type) {
      case 0:
        _generateAdditionTask();
        break;
      case 1:
        _generateSubtractionTask();
        break;
      case 2:
        _generateMultiplicationTask();
        break;
      case 3:
        _generateDivisionTask();
        break;
    }
  }

  void _generateAdditionTask() {
    var a = randomInt(1, 100);
    var b = randomInt(1, 100);

    _task = '$a + $b   =    ?';
    _rightResult = a + b;
  }

  void _generateSubtractionTask() {
    var a = randomInt(1, 100);
    var b = randomInt(1, 100);

    if (b > a) {
      var tmp = a;
      a = b;
      b = tmp;
    }

    _task = '$a - $b   =    ?';
    _rightResult = a - b;
  }

  void _generateMultiplicationTask() {
    var a = randomInt(2, 13);
    var b = randomInt(2, 13);

    _task = '$a * $b   =    ?';
    _rightResult = a * b;
  }

  void _generateDivisionTask() {
    var a = randomInt(2, 13);
    var b = randomInt(2, 13);

    var result = a * b;

    _task = '$result / $a   =    ?';
    _rightResult = b;
  }

  void _showFalse() {
    setState(() {
      _wasFalse = true;
      Timer(new Duration(seconds: 1), () {
        setState(() {
          _wasFalse = false;
        });
      });
    });
  }

  void _showRight() {
    setState(() {
      _wasRight = true;
      Timer(new Duration(seconds: 1), () {
        setState(() {
          _wasRight = false;
        });
      });
    });
  }

  MaterialColor _getColor() {
    if (_wasRight) {
      return Colors.green;
    }

    if (_wasFalse) {
      return Colors.red;
    }

    return Colors.blue;
  }

  void _increaseScore() {
    _score += 1;
    // widget.setScore(_score);
  }

  void _decreaseScore(){
    _score -= 1;
  }

  void _checkInput() {
    try {
      if (int.parse(_inputController.text) == _rightResult) {
        _showRight();
        _generateTask();
        _increaseScore();
      } else {
        _showFalse();
        _decreaseScore();
      }
    } catch (_) {
      _showFalse();
      _decreaseScore();
    } finally {
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        leading: InkWell(onTap: (){Navigator.pop(context);},child: const Icon(Icons.arrow_back_ios,color: Colors.black,),),
        title: Text("Kopfberechnung",style: AppTextStyle.tabBarTextStyle,),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 45),
            child: Card(
              elevation: 3,
              child: Center(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Punktzahl: $_score',style: AppTextStyle.scoreTextTextStyle),
                  )),),
          ),
          SizedBox(height: size.height *0.04,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade400,borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Text(
                  _task,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height *0.02,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(elevation: 2,
              child: ListTile(
                leading: const Text('Antworten :',style: TextStyle(fontSize: 30,fontFamily: 'Raleway',),),
                title: TextField(
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) => _checkInput(),
                  controller: _inputController,
                  style:  TextStyle(fontSize: 20,fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ),
          SizedBox(height: 35,),
          InkWell(
              onTap: (){
            _checkInput();
          },
              child: Padding(
            padding: const EdgeInsets.only(right: 15,left: 15),
            child: Container(
              height: size.height * 0.06,
              width: 120,
              decoration: BoxDecoration(color: _getColor(),borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text('Einreichen',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Montserrat'),)),),
          )
          )
          // Center(child: Text("Total Score : $_score"))
        ],
      ),
    );
  }
}


