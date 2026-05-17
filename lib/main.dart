import 'package:flutter/material.dart';

void main() {
  runApp(const DarkCalcApp());
}

class DarkCalcApp extends StatelessWidget {
  const DarkCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DarkCalc',
      theme: ThemeData.dark(),
      home: const CalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  double _firstOperand = 0;
  String? _operation;
  bool _isSecondOperand = false;

  void _numPressed(String num) {
    setState(() {
      if (_display == '0' || (_isSecondOperand && _display == '0')) {
        _display = num;
      } else {
        _display += num;
      }
      _isSecondOperand = true;
    });
  }

  void _operatorPressed(String op) {
    setState(() {
      _firstOperand = double.tryParse(_display) ?? 0;
      _operation = op;
      _isSecondOperand = false;
      _display = '0';
    });
  }

  void _calculateResult() {
    setState(() {
      double secondOperand = double.tryParse(_display) ?? 0;
      double result = 0;
      switch (_operation) {
        case '+':
          result = _firstOperand + secondOperand;
          break;
        case '-':
          result = _firstOperand - secondOperand;
          break;
        case '*':
          result = _firstOperand * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            _display = 'Error';
            _operation = null;
            return;
          }
          result = _firstOperand / secondOperand;
          break;
      }
      _display = result.toString().replaceAll(RegExp(r'\.?0+$'), '');
      _operation = null;
      _isSecondOperand = false;
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = 0;
      _operation = null;
      _isSecondOperand = false;
    });
  }

  Widget _buildButton(String text,
      {Color? color, required VoidCallback onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.grey[800],
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DarkCalc'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7',
                      onPressed: () => _numPressed('7')),
                  _buildButton('8',
                      onPressed: () => _numPressed('8')),
                  _buildButton('9',
                      onPressed: () => _numPressed('9')),
                  _buildButton('/',
                      color: Colors.orange,
                      onPressed: () => _operatorPressed('/')),
                ],
              ),
              Row(
                children: [
                  _buildButton('4',
                      onPressed: () => _numPressed('4')),
                  _buildButton('5',
                      onPressed: () => _numPressed('5')),
                  _buildButton('6',
                      onPressed: () => _numPressed('6')),
                  _buildButton('*',
                      color: Colors.orange,
                      onPressed: () => _operatorPressed('*')),
                ],
              ),