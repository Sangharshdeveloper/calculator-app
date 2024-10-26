import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/test.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController textEditingController = TextEditingController();
  String userInputA = '';
  String userInputB = '';
  String method = '';
  String displayText = '';

  List<String> inputLists = [
    'AC',
    '0',
    '=',
    '',
    '7',
    '8',
    '9',
    '%',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-'
  ];

  String finalAnswer = '';
  void buttonPressed(String input) {
    setState(() {
      if (input == 'AC') {
        userInputA = '';
        userInputB = '';
        method = '';
        displayText = '';
        finalAnswer = '';
        textEditingController.clear();
      } else if (input == '-' || input == '+' || input == '÷' || input == '%') {
        method = input;
      } else {
        if (method.isEmpty) {
          userInputA += input;
          displayText = userInputA;
        } else {
          userInputB += input;
          displayText = '$userInputA $method $userInputB';
        }
      }

      textEditingController.text = displayText.toString().replaceAll('=', '');
    });
  }

  void calculateResult() {
    if (userInputA.isNotEmpty && userInputB.isNotEmpty && method.isNotEmpty) {
      int numA = int.parse(userInputA);
      int numB = int.parse(userInputB);
      int result;

      displayText = '';
      switch (method) {
        case '+':
          result = numA + numB;
          break;

        case '-':
          result = numA - numB;
          break;

        case '%':
          result = numA % numB;
          break;

        default:
          result = 0;
      }

      setState(() {
        displayText = result.toString();
        finalAnswer = displayText;
        textEditingController.text == displayText;
      });
    }
  }

  double calculate(double numA, double numB, String method) {
    double result;
    switch (method) {
      case '+':
        result = numA + numB;
        break;
      case '-':
        result = numA - numB;
        break;
      case '%':
        result = numA % numB;
        break;
      default:
        result = 0;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextField(
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: textEditingController,
                readOnly: true,
                style: const TextStyle(fontSize: 40),
                showCursor: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    finalAnswer,
                    style: const TextStyle(fontSize: 40),
                  )),
            ),
            SizedBox(
              height: 480,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: inputLists.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      if (inputLists[index] == '=')
                        {
                          group('Calculator Tests', () {
                            test('Addition test', () {
                              final result = calculate(2, 3, '+');
                              expect(result, 5);
                            });

                            test('Subtraction test', () {
                              final result = calculate(5, 3, '-');
                              expect(result, 2);
                            });

                            test('Modulus test', () {
                              final result = calculate(10, 3, '%');
                              expect(result, 1);
                            });

                            test('Default case test', () {
                              final result = calculate(
                                  10, 3, '*'); // Unsupported operation
                              expect(result, 0);
                            });
                          }),
                          calculateResult(),
                        },
                      buttonPressed(inputLists[index])
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          inputLists[index],
                          style: const TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
