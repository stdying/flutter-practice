import 'package:flutter/material.dart';
import 'package:flutter_practice/models/function_items.dart';
import 'package:flutter_practice/router/app_route_information_parser.dart';
import 'package:flutter_practice/router/app_router_delegate.dart';

void main() {
  runApp(Nav2App());
}

class Nav2App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Nav2AppState();
}

class Nav2AppState extends State<Nav2App> {
  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  AppRouteInformationParser _informationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Function',
        routeInformationParser: _informationParser,
        routerDelegate: _routerDelegate);
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("404!"),
            TextButton(
                child: Text("Pop"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

class FunctionDetailScreen extends StatelessWidget {
  final FunctionItem functionItem;

  FunctionDetailScreen({
    @required this.functionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(functionItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (functionItem != null) ...[Text(functionItem.title)]
          ],
        ),
      ),
    );
  }
}

class FunListScreen extends StatelessWidget {
  final List<FunctionItem> items;
  final ValueChanged<FunctionItem> onTapped;

  FunListScreen({
    Key key,
    @required this.items,
    @required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MaterialApp",
      home: Scaffold(
        appBar: AppBar(
          title: Text("AppBar"),
        ),
        body: ListView.separated(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: buildTitle(context, item.title),
              onTap: () => onTapped(item),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return new Divider(
              height: 1.0,
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
//
// abstract class ListItem {
//   Widget buildTitle(BuildContext context);
//
//   Widget buildSubTitle(BuildContext context);
// }
//
// class HeadingItem implements ListItem {
//   final String heading;
//
//   HeadingItem(this.heading);
//
//   @override
//   Widget buildSubTitle(BuildContext context) {
//     return Text(
//       heading,
//       style: Theme.of(context).textTheme.headline5,
//     );
//   }
//
//   @override
//   Widget buildTitle(BuildContext context) => null;
// }
//
// class MessageItem implements ListItem {
//   final String sender;
//   final String body;
//
//   MessageItem(this.sender, this.body);
//
//   @override
//   Widget buildSubTitle(BuildContext context) => Text(this.sender);
//
//   @override
//   Widget buildTitle(BuildContext context) => Text(this.body);
// }
