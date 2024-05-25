import 'package:get_it/get_it.dart';
import 'package:time_waster/calculator/di.dart';

late GetIt locator;

injectDependencies([GetIt? getIt]) {
  locator = getIt ?? GetIt.instance;
  registerCalculatorModule(locator);
}
