import 'package:flutter/material.dart';
import 'package:flutter_practice/main.dart';
import 'package:flutter_practice/models/function_items.dart';


class FunctionDetailPage extends Page {
  final FunctionItem functionItem;

  FunctionDetailPage({
    this.functionItem,
  }) : super(key: ValueKey(functionItem));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return FunctionDetailScreen(
          functionItem: this.functionItem,
        );
      },
    );
  }
}
