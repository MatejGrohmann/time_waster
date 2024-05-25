import 'package:get_it/get_it.dart';

import 'calculator_controller.dart';

registerCalculatorModule(GetIt locator) {
  locator.registerFactory<CalculatorController>(CalculatorController.new);
}