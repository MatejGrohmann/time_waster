part of '../simple_state_management.dart';

class _SimpleStreamObservable<T extends Object?> {
  T _value;

  final _streamController = StreamController<T>.broadcast();

  final List<_StreamObservableState> _parents = List.empty(growable: true);

  _SimpleStreamObservable({required T value}) : _value = value;

  T get value {
    final parent = _StreamObservableState.proxy;
    if (parent != null && parent.canRegister) {
      _addParent(parent);
    }
    return _value;
  }

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _streamController.add(_value);
      for (var index = _parents.length - 1; index >= 0; index--) {
        final parent = _parents[index];
        if (parent._canUpdate) {
          parent._onUpdate();
        } else {
          _parents.removeAt(index);
        }
      }
    }
  }

  Stream<T?> get stream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  _addParent(_StreamObservableState parent) {
    if (!_parents.contains(parent)) {
      _parents.add(parent);
    }
  }
}

class _StreamObservableBuilder extends StatefulWidget {
  final Widget? Function() builder;

  const _StreamObservableBuilder({required this.builder, super.key});

  @override
  State<_StreamObservableBuilder> createState() => _StreamObservableState();
}

class _StreamObservableState extends State<_StreamObservableBuilder> {
  static _StreamObservableState? proxy;

  bool canRegister = false;

  @override
  Widget build(BuildContext context) {
    canRegister = true;

    _StreamObservableState.proxy = this;
    final child = widget.builder();

    canRegister = false;
    return child ?? const SizedBox.shrink();
  }

  bool get _canUpdate => mounted;

  _onUpdate() => setState(() {});
}
