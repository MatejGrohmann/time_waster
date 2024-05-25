import 'package:flutter/material.dart';
import 'package:simple_state_management/simple_state_management.dart';

import '../config/di.dart';
import 'calculator_controller.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: ControllerWidget<CalculatorController>(
        create: () => locator<CalculatorController>(),
        builder: (controller) {
          return ReactiveWidget(
            () {
              if (controller.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16.0),
                      Text('Performing hardcore calculation...'),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: controller.form,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.firstNumberController,
                            decoration: const InputDecoration(labelText: 'First number'),
                            validator: controller.numberRegexValidator,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            controller: controller.secondNumberController,
                            decoration: const InputDecoration(labelText: 'Second number'),
                            validator: controller.numberRegexValidator,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Wrap(
                    spacing: 16.0,
                    alignment: WrapAlignment.spaceEvenly,
                    runSpacing: 16.0,
                    children: [
                      ElevatedButton(
                        onPressed: controller.addNumbers,
                        child: const Text('Add numbers'),
                      ),
                      ElevatedButton(
                        onPressed: controller.subtractNumbers,
                        child: const Text('Subtract numbers'),
                      ),
                      ElevatedButton(
                        onPressed: controller.multiplyNumbers,
                        child: const Text('Multiply numbers'),
                      ),
                      ElevatedButton(
                        onPressed: controller.divideNumbers,
                        child: const Text('Divide numbers'),
                      ),
                    ],
                  ),
                  ReactiveWidget(
                    () {
                      if (controller.result.value != null) {
                        return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'Result: \n${controller.result.value}',
                            style: const TextStyle(fontSize: 24.0),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: controller.clearResult,
                    child: const Text('Clear'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
