import 'package:flutter/cupertino.dart';
import 'package:news/src/blocs/stories_bloc.dart';
export 'package:news/src/blocs/stories_bloc.dart';

class StroiesProvider extends InheritedWidget {
  late final StoriesBloc bloc;

  StroiesProvider({Key? key, required Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType() as StroiesProvider)
        .bloc;
  }
}
