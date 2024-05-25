part of '../simple_state_management.dart';

abstract interface class _ControllerInterface {
  void onInit();

  void onReady();

  void onDispose();

  void injectContext(BuildContext context);
}

class _ControllerEnvironment<T extends _ControllerInterface> extends StatefulWidget {
  const _ControllerEnvironment({required this.create, required this.builder, super.key});

  final T Function() create;
  final Widget? Function(T) builder;

  @override
  State<_ControllerEnvironment> createState() => _ControllerEnvironmentState<T>();
}

class _ControllerEnvironmentState<T extends _ControllerInterface> extends State<_ControllerEnvironment<T>> {
  T? controller;

  @override
  void initState() {
    controller = widget.create();
    controller?.onInit();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller?.onReady();
    controller?.injectContext(context);
  }

  @override
  void dispose() {
    controller?.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(controller!) ?? const SizedBox.shrink();
  }
}
