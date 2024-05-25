library simple_state_management;

import 'dart:async';
import 'package:flutter/material.dart';

part 'src/simple_state_management.stream_observable.dart';

part 'src/simple_state_management.controller_lifecycle.dart';

class Reactive<T extends Object?> extends _SimpleStreamObservable<T> {
  Reactive._(T value) : super(value: value);

  factory Reactive([T? value]) {
    return Reactive._(value ?? null as T);
  }
}

class ReactiveWidget extends _StreamObservableBuilder {
  const ReactiveWidget(Widget? Function() builder, {super.key}) : super(builder: builder);
}

abstract class Controller implements _ControllerInterface {
  late BuildContext context;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @protected
  injectContext(BuildContext context) {
    this.context = context;
  }
}

class ControllerWidget<T extends _ControllerInterface> extends _ControllerEnvironment<T> {
  const ControllerWidget({
    required super.create,
    required super.builder,
    super.key,
  });
}
