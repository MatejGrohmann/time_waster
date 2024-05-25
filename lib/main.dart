import 'package:flutter/material.dart';
import 'package:time_waster/config/di.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies();
  runApp(const App());
}
