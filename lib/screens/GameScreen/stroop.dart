import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/app_text_style.dart';

class Stroop extends StatefulWidget {
  const Stroop({Key? key}) : super(key: key);

  @override
  _StroopState createState() => _StroopState();
}

var colors = {
  'Rot': Colors.red.shade700,
  'Grün': Colors.green,
  'Blau': Colors.blue,
  'Gelb': Colors.yellow,
  'Lila': Colors.deepPurple,
  'Orange': Colors.orange,
  'Braun': Colors.brown,
  'Rosa': Colors.pink.shade300,
  'Schwarz': Colors.black,
};

class _StroopState extends State<Stroop> {
  var _color;
  var _colorText;
  var _random = new Random();
  var _score = 0;

  var _colorTexts = colors.keys.toList();
  var _colors = colors.values.toList();

  _StroopState() {
    _generateTask();
  }

  _generateTask() {
    _generateColor();
    _colorTexts.shuffle();
    _colors.shuffle();
  }

  _generateColor() {
    _colorText = colors.keys.elementAt(_random.nextInt(colors.length));
    _color = colors.values.elementAt(_random.nextInt(colors.length));
  }

  _checkResult(Color color) {
    var inputColor = color;

    if (inputColor == _color) {
      _score++;
      _generateTask();
    } else {
      _score--;
    }

    setState(() {});
  }

  Widget _generateButtonRow(int index) {
    List<Widget> buttons = [];

    for (var i = 0; i < 3; i++) {
      var totalIndex = index * 3 + i;
      var colorText = _colorTexts[totalIndex];

      var button = Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){_checkResult(_colors[totalIndex]);},
          child: Container(
            height: MediaQuery.of(context).size.height/18,
            width: (MediaQuery.of(context).size.width/3) - 20,
            decoration: BoxDecoration(color: _colors[totalIndex],borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text(colorText,style:AppTextStyle.whiteTextStyle,)),
          ),
        ),
      );

    //   var button = ElevatedButton(
    //     child: Text(colorText),
    //     onPressed: () => {_checkResult(colorText)},
    //     style: ElevatedButton.styleFrom(backgroundColor: _colors[totalIndex]),
    //   );
      buttons.add(button);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buttons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: InkWell(onTap: (){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        centerTitle: true,
        title: Text("Stroop",style: AppTextStyle.tabBarTextStyle,),
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
              elevation: 10,
              child: SizedBox(
                height: MediaQuery.of(context).size.height/6,
                child: Center(
                    child: Text(_colorText,
                        style: TextStyle(fontSize: 80, color: _color,fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',))),
              ),
            ),
          ),
          SizedBox(height: 20,),
          _generateButtonRow(0),
          _generateButtonRow(1),
          _generateButtonRow(2),
        ],
      ),
    );
  }
}
