import 'package:flutter/material.dart';

typedef BlocDisposer<T> = Function(T);

class _BlocProviderInherited<T> extends InheritedWidget {
  final T bloc;
  const _BlocProviderInherited(
      {Key? key, required Widget child, required this.bloc})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final BlocDisposer<T> blocDisposer;
  final Widget child;

  const BlocProvider(
      {Key? key,
      required this.child,
      required this.bloc,
      required this.blocDisposer})
      : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    _BlocProviderInherited<T> provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>;
    return provider.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  late T bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.bloc;
  }

  @override
  void dispose() {
    widget.blocDisposer(bloc);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child,
    );
  }
}
