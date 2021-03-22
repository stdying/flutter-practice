import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_practice/main.dart';
import 'package:flutter_practice/models/function_items.dart';

import 'package:flutter_practice/router/app_route_path.dart';
import 'package:flutter_practice/router/function_detail_page.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  FunctionItem _functionItem;
  bool show404 = false;

  final List<FunctionItem> items = [
    FunctionItem("Provider"),
    FunctionItem("demo1"),
    FunctionItem("demo2"),
    FunctionItem("demo3"),
    FunctionItem("demo4"),
    FunctionItem("demo5"),
    FunctionItem("demo6"),
    FunctionItem("demo7"),
    FunctionItem("demo8"),
    FunctionItem("demo9"),
    FunctionItem("demo10"),
    FunctionItem("demo11"),
    FunctionItem("demo12")
  ];

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: ValueKey('FunctionListPage'),
            child: FunListScreen(
              items: this.items,
              onTapped: _handleFunctionItem,
            )),
        if (show404)
          MaterialPage(key: ValueKey('UnknowPage'), child: UnknownScreen())
        else if (_functionItem != null)
          FunctionDetailPage(functionItem: _functionItem)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _functionItem = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  AppRoutePath get currentConfiguration {
    if (show404) {
      return AppRoutePath.unknown();
    }

    return _functionItem == null
        ? AppRoutePath.home()
        : AppRoutePath.details(items.indexOf(_functionItem));
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    if (path.isUnknown) {
      _functionItem = null;
      show404 = true;
      return;
    }

    if (path.isDetailPage) {
      if (path.id == null) {
        show404 = true;
        return;
      }
      _functionItem = items[path.id];
    } else {
      _functionItem = null;
    }
    show404 = false;
  }

  void _handleFunctionItem(FunctionItem functionItem) {
    _functionItem = functionItem;
    notifyListeners();
  }
}
