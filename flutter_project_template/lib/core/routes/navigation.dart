import 'package:flutter/widgets.dart';

List<Widget> pages = [];

void push(BuildContext context, Widget widget, {bool isFullScreen = false}) {
  Navigator.of(context).push(_createRoute(widget, isFullScreen: isFullScreen));
  pages.add(widget);
}

void pushAndReplace(BuildContext context, Widget widget,
    {bool isFullScreen = false}) {
  Navigator.of(context)
      .pushReplacement(_createRoute(widget, isFullScreen: isFullScreen));
  if (pages.length > 0) {
    pages[pages.length - 1] = widget;
  }
}

void pop(BuildContext context) {
  Navigator.of(context).pop();
  pages.removeLast();
}

enum AnimationTransitionType {
  slide_right,
  slide_left,
  slide_up,
  slide_down,
  fade,
  scale,
}
Route _createRoute(Widget widget,
    {AnimationTransitionType animationType =
        AnimationTransitionType.slide_right,
    bool isFullScreen = false}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    fullscreenDialog: isFullScreen,
  );
}
