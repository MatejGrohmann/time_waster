import 'package:flutter/material.dart';
import 'package:simple_state_management/simple_state_management.dart';

class CalculatorController extends Controller {
  final form = GlobalKey<FormState>();

  final isLoading = Reactive<bool>(false);
  final result = Reactive<String?>();

  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();

  @override
  void onDispose() {
    firstNumberController.dispose();
    secondNumberController.dispose();
    result.dispose();
    isLoading.dispose();
  }

  String? numberRegexValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }

    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    return null;
  }

  void subtractNumbers() {
    if (form.currentState!.validate()) {
      startLoading();
      final firstNumber = int.parse(firstNumberController.text);
      final secondNumber = int.parse(secondNumberController.text);

      result.value = (firstNumber - secondNumber).toString();
      Future.delayed(const Duration(seconds: 1)).then((_) {
        stopLoading();
        showMessage('Result: ${result.value}');
      });
    } else {
      showMessage('Form neni valid pyco');
    }
  }

  void multiplyNumbers() {
    if (form.currentState!.validate()) {
      startLoading();
      final firstNumber = int.parse(firstNumberController.text);
      final secondNumber = int.parse(secondNumberController.text);

      result.value = (firstNumber * secondNumber).toString();
      Future.delayed(const Duration(seconds: 1)).then((_) {
        stopLoading();
        showMessage('Result: ${result.value}');
      });
    } else {
      showMessage('Form neni valid pyco');
    }
  }

  void divideNumbers() {
    if (form.currentState!.validate()) {
      startLoading();
      final firstNumber = int.parse(firstNumberController.text);
      final secondNumber = int.parse(secondNumberController.text);

      result.value = (firstNumber / secondNumber).toString();
      Future.delayed(const Duration(seconds: 1)).then((_) {
        stopLoading();
        showMessage('Result: ${result.value}');
      });
    } else {
      showMessage('Form neni valid pyco');
    }
  }

  void addNumbers() {
    if (form.currentState!.validate()) {
      startLoading();
      final firstNumber = int.parse(firstNumberController.text);
      final secondNumber = int.parse(secondNumberController.text);

      result.value = (firstNumber + secondNumber).toString();
      Future.delayed(const Duration(seconds: 1)).then((_) {
        stopLoading();
        showMessage('Result: ${result.value}');
      });
    } else {
      showMessage('Form neni valid pyco');
    }
  }

  startLoading() {
    isLoading.value = true;
  }

  stopLoading() {
    isLoading.value = false;
  }

  showMessage(String message) {
    if (context.mounted) {
      ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void clearResult() {
    FocusScope.of(context).unfocus();
    form.currentState?.reset();
    result.value = null;
    firstNumberController.clear();
    secondNumberController.clear();
    showMessage('Ciste jako sklo');
  }
}
