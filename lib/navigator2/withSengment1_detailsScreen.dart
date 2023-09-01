import 'package:flutter/material.dart';
import 'package:hive_pract/views/details.screen.dart';

import 'views/error.screen.dart';
import 'views/home.dart';
import 'views/settings.screen.dart';

main() {
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  // Hive.init(appDocumentDir.path);
  // Hive.registerAdapter(UserAdapter());

  runApp(MyApp());
}

enum PageName { home, setting, details, profile }

class AppRoutePath {
  final PageName? _selectedPage;
  final bool isUnkwon;
  final int? id;

  AppRoutePath.home()
      : _selectedPage = null,
        isUnkwon = false,
        id = null;

  AppRoutePath.setting()
      : _selectedPage = PageName.setting,
        id = null,
        isUnkwon = false;

  AppRoutePath.profile()
      : _selectedPage = PageName.profile,
        id = null,
        isUnkwon = false;

  AppRoutePath.details(this.id)
      : _selectedPage = PageName.details,
        isUnkwon = false;

  AppRoutePath.unknown()
      : isUnkwon = true,
        id = null,
        _selectedPage = null;

  bool get isHomePage => _selectedPage == null && !isUnkwon;
  bool get isSettingPage => _selectedPage == PageName.setting && !isUnkwon;
  bool get isProfilePage => _selectedPage == PageName.profile && !isUnkwon;
  bool get isDetailsPage =>
      _selectedPage == PageName.details && id != null && !isUnkwon;
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    currentConfiguration;
  }

  PageName? pageName;
  bool show404 = false;
  int? id;

  AppRoutePath get currentConfiguration {
    if (show404) {
      return AppRoutePath.unknown();
    }

    ///* will responsible to show urlBar
    if (pageName == null) return AppRoutePath.home();
    if (pageName == PageName.setting) return AppRoutePath.setting();
    if (pageName == PageName.profile) return AppRoutePath.profile();
    if (pageName == PageName.details) {
      //todo:check unknown later
      if (id != null)
        return AppRoutePath.details(id);
      else
        return AppRoutePath.unknown();
    }
    return AppRoutePath.unknown();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey("HomePage"),
          child: HomeScreen(),
        ),
        if (show404)
          MaterialPage(
            key: ValueKey("Error Screen"),
            child: ErrorScreen(),
          ),
        if (pageName == PageName.setting)
          MaterialPage(
            key: ValueKey("settingPage"),
            child: Settings(),
          ),
        if (pageName == PageName.profile)
          MaterialPage(
            key: ValueKey("ProfilePage"),
            child: Profile(),
          ),
        if (pageName == PageName.details)
          MaterialPage(
            key: ValueKey("details"),
            child: DetailsScreen(
              index: id,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        pageName = null;
        show404 = false;
        id = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isUnkwon) {
      show404 = true;
      pageName = null;
      id = null;
    }
    if (configuration.isHomePage) {
      show404 = false;
      pageName = null;
      id = null;
    }

    if (configuration.isSettingPage) {
      show404 = false;
      pageName = PageName.setting;
      id = null;
    }

    if (configuration.isProfilePage) {
      show404 = false;
      pageName = PageName.profile;
      id = null;
    }

    if (configuration.isDetailsPage) {
      show404 = false;
      id = configuration.id;
      pageName = PageName.details;
    }
  }
}

/// RouteInformationParser
class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? "/");

    print(uri.pathSegments);

    ///* handle '/'
    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.home();
    }

    if (uri.pathSegments[0] == "setting") return AppRoutePath.setting();
    if (uri.pathSegments[0] == "profile") return AppRoutePath.profile();
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != "details") return AppRoutePath.unknown();
      final id = int.tryParse(uri.pathSegments[1]);
      if (id == null) return AppRoutePath.unknown();
      return AppRoutePath.details(id);
    }
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnkwon) {
      return RouteInformation(location: '/404');
    }

    if (configuration.isSettingPage) {
      return RouteInformation(location: '/setting');
    }

    if (configuration.isProfilePage) {
      return RouteInformation(location: '/profile');
    }

    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/details/${configuration.id}');
    }
    return RouteInformation(location: '/');
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
