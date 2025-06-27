import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../../constants/app_text_style.dart';

class Remember extends StatefulWidget {
  const Remember({Key? key}) : super(key: key);

  @override
  _RememberState createState() => _RememberState();
}

const fadeDurationMs = 500;
const visibleDurationMs = 200;
const pauseDurationMs = 100;
const fadeDuration = const Duration(milliseconds: fadeDurationMs);
const visibleDuration =
    const Duration(milliseconds: fadeDurationMs + visibleDurationMs);
const pauseDuration =
    const Duration(milliseconds: fadeDurationMs + pauseDurationMs);

var random = Random();

List<int> _generateSequence() {
  List<int> seq = [];

  for (var i = 0; i < 5; i++) {
    seq.add(random.nextInt(9));
  }

  return seq;
}

class _RememberState extends State<Remember> {
  var _visible = false;
  var _isRunning = false;
  var _number = 0;
  var _inputController = TextEditingController();
  var _score = 0;
  var _seqString = "";
  var _isWaitingForInput = false;
  var _wasFalse = false;
  var _wasRight = false;

  _start() async {
    if (_isRunning) {
      return;
    }
    _isRunning = true;
    var seq = _generateSequence();
    _seqString = seq.fold<String>(
        "", (previousValue, element) => previousValue + element.toString());
    print(_seqString);

    print(seq);

    for (var i = 0; i < seq.length; i++) {
      setState(() {
        _visible = true;
        _number = seq[i];
      });
      await Future.delayed(visibleDuration);
      setState(() {
        _visible = false;
      });
      await Future.delayed(pauseDuration);
    }
    setState(() {
      _isRunning = false;
      _isWaitingForInput = true;
    });
  }

  _onSubmit() {
    print(_inputController.text);
    var input = _inputController.text;
    if (input == _seqString) {
      _showRight();
      _score++;
    } else {
      _showFalse();
      _score--;
    }
    _inputController.clear();
    setState(() {
      _isWaitingForInput = false;
    });
  }

  void _showFalse() {
    setState(() {
      _wasFalse = true;
      Timer(const Duration(seconds: 1), () {
        setState(() {
          _wasFalse = false;
        });
      });
    });
  }

  void _showRight() {
    setState(() {
      _wasRight = true;
      Timer(const Duration(seconds: 1), () {
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: InkWell(onTap: (){Navigator.pop(context);},child: const Icon(Icons.arrow_back_ios,color: Colors.black,),),
        centerTitle: true,
        title: Text("Erinnern",style: AppTextStyle.tabBarTextStyle,),
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
                    child: Text('Punktzahl: $_score', style: AppTextStyle.scoreTextTextStyle),
                  )),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 5,
              child: SizedBox(
                width: size.width,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: fadeDurationMs),
                  opacity: _visible ? 1.0 : 0.0,
                  child: Center(
                    child: Text(
                      _number.toString(),
                      style: const TextStyle(fontSize: 100),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (!_isRunning && !_isWaitingForInput)
            InkWell(
                onTap: (){
                  _start();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 35,right: 15,left: 15),
                  child: Container(
                    height: size.height * 0.06,
                    width: 120,
                    decoration: BoxDecoration(color: _getColor(),borderRadius: BorderRadius.circular(8)),
                    child: const Center(child: Text('Start',style: TextStyle(fontSize: 20,fontFamily: 'Montserrat'),),),
                )
            )),
          if (_isWaitingForInput)
            Column(children: [
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(elevation: 2,
                child: ListTile(
                  leading: const Text('Antworten :',style: TextStyle(fontSize: 30,fontFamily: 'Raleway',),),
                  title: TextField(
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) => _onSubmit(),
                    controller: _inputController,
                    style:  const TextStyle(fontSize: 20,fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
              const SizedBox(height: 35,),
              InkWell(
                  onTap: (){
                    _onSubmit();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15),
                    child: Container(
                      height: size.height * 0.06,
                      width: 120,
                      decoration: BoxDecoration(color: _getColor(),borderRadius: BorderRadius.circular(8)),
                      child: const Center(child: Text('Einreichen',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Montserrat'),)),),
                  )
              ),
            ],)
          // Center(child: Text("Score: $_score", style: TextStyle(fontSize: 30))),
        ],
      ),
    );
  }
}
