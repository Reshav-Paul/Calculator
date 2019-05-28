import 'package:flutter/material.dart';
import '../Utilities/ui_colors.dart';

class BasicCalculator extends StatefulWidget {
  @override
  _BasicCalculatorState createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  String output, input1;
  String operand;

  initState() {
    output = "0";
    input1 = "";
    operand = "";
    super.initState();
  }

  Widget getButton(
      {String text,
      Color btnColor = Colors.white,
      Color fntColor = Colors.black,
      int flex = 1}) {
    return Expanded(
      flex: flex,
      child: new Material(
        color: btnColor,
        child: new InkWell(
          splashColor: Colors.transparent,
          child: new Center(
              child: new Text(
            text,
            style: TextStyle(fontSize: 20.0, color: fntColor),
          )),
          onTap: () => setState(() => _buttonPressed(text)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Row(
        children: <Widget>[
          new SizedBox(width: 45.0),
          new Expanded(
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: 10,
                ),
                new Expanded(
                  flex: 2,
                  child: new Align(
                      alignment: Alignment.centerRight,
                      child: new Text(
                        output,
                        style: TextStyle(fontSize: 25.0, color: Colors.black54),
                      )),
                ),
                new Expanded(
                    flex: 2,
                    child: new Align(
                        alignment: Alignment.centerRight,
                        child: new Text(operand,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black)))),
                new Expanded(
                    flex: 3,
                    child: new Align(
                        alignment: Alignment.centerRight,
                        child: new Text(input1,
                            style: TextStyle(
                                fontSize: 30.0, color: Colors.black)))),
                new Expanded(
                  flex: 2,
                  child: new Row(
                    children: <Widget>[
                      getButton(
                          text: "Clear",
                          flex: 2,
                          btnColor: darkBackgroundColor,
                          fntColor: Colors.white),
                      getButton(
                          text: "%",
                          btnColor: darkBackgroundColor,
                          fntColor: Colors.white),
                      getButton(
                          text: "=",
                          btnColor: darkBackgroundColor,
                          fntColor: Colors.white)
                    ],
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Row(
                    children: <Widget>[
                      getButton(text: "1"),
                      getButton(text: "2"),
                      getButton(text: "3"),
                      getButton(
                          text: "+",
                          btnColor: darkButtonColor,
                          fntColor: Colors.white)
                    ],
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Row(
                    children: <Widget>[
                      getButton(text: "4"),
                      getButton(text: "5"),
                      getButton(text: "6"),
                      getButton(
                          text: "-",
                          btnColor: darkButtonColor,
                          fntColor: Colors.white)
                    ],
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Row(
                    children: <Widget>[
                      getButton(text: "7"),
                      getButton(text: "8"),
                      getButton(text: "9"),
                      getButton(
                          text: "x",
                          btnColor: darkButtonColor,
                          fntColor: Colors.white)
                    ],
                  ),
                ),
                new Expanded(
                  flex: 3,
                  child: new Row(
                    children: <Widget>[
                      getButton(text: "."),
                      getButton(text: "0"),
                      getButton(text: "Del"),
                      getButton(
                          text: "/",
                          btnColor: darkButtonColor,
                          fntColor: Colors.white)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buttonPressed(String buttonText) {
    if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "x") {
      if (operand.length > 0 && input1.length > 0) {
        _calculate();
        operand = buttonText;
        input1 = "";
        return;
      }
      operand = buttonText;
      output = (input1.length > 0) ? input1 : output;
      _truncate();
      input1 = "";
    } else if (buttonText == ".") {
      if (input1.contains(".")) return;
      if (input1.length == 0) input1 = "0";
      input1 = input1 + buttonText;
    } else if (buttonText == "Clear") {
      input1 = operand = "";
      output = "0";
    } else if (buttonText == "=") {
      if (input1.length == 0) return;
      if (operand.length == 0) {
        output = input1;
        input1 = "";
        return;
      }
      _calculate();
    } else if (buttonText == "Del") {
      if (operand.length > 0 && input1.length == 0) {
        operand = "";
        input1 = output;
        output = "0";
      } else {
        if (input1.length > 0) input1 = input1.substring(0, input1.length - 1);
      }
    } else if (buttonText == "%") {
      if (input1.length == 0 && operand.length == 0) {
        output = (double.parse(output) == 0) ? input1 : output;
        output = (double.parse(output) / 100).toStringAsPrecision(10);
        _truncate();
      } else if (input1.length == 0 && operand.length > 0)
        return;
      else {
        output = (double.parse(input1) / 100).toStringAsPrecision(10);
        _truncate();
        input1 = "";
      }
    } else {
      input1 = input1 + buttonText;
    }
  }

  _calculate() {
    if (operand == "+")
      output =
          (double.parse(output) + double.parse(input1)).toStringAsPrecision(10);
    if (operand == "-")
      output =
          (double.parse(output) - double.parse(input1)).toStringAsPrecision(10);
    if (operand == "/")
      output =
          (double.parse(output) / double.parse(input1)).toStringAsPrecision(10);
    if (operand == "x")
      output =
          (double.parse(output) * double.parse(input1)).toStringAsPrecision(10);
    input1 = output;
    _truncate();
    operand = "";
  }

  _truncate() {
    if(output.length == 0)return;
    String temp = double.parse(output).toStringAsFixed(6);
    if (double.parse(output).truncateToDouble() == double.parse(output))
      output = input1 = double.parse(output).truncate().toString();
    else if (double.parse(output) == double.parse(temp)) output = input1 = temp;
  }
}
