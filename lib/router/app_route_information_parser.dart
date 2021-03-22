import 'package:flutter/widgets.dart';
import 'package:flutter_practice/router/app_route_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length == 0) {
      return AppRoutePath.home();
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'fun') return AppRoutePath.unknown();

      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return AppRoutePath.unknown();
      return AppRoutePath.details(id);
    }
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailPage) {
      return RouteInformation(location: '/fun/${path.id}');
    }
    return null;
  }
}
