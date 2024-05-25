import 'package:flutter/material.dart';

import 'calculator/calculator_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      home: CalculatorPage(),
    );
  }
}
