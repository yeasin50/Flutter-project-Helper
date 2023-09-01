import 'package:flutter/material.dart';

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
  bool isUnkwon;

  AppRoutePath.home()
      : _selectedPage = null,
        isUnkwon = false;

  AppRoutePath.setting()
      : _selectedPage = PageName.setting,
        isUnkwon = false;

  AppRoutePath.profile()
      : _selectedPage = PageName.profile,
        isUnkwon = false;

  AppRoutePath.unknown()
      : isUnkwon = true,
        _selectedPage = null;

  bool get isHomePage => _selectedPage == null && !isUnkwon;
  bool get isSettingPage => _selectedPage == PageName.setting && !isUnkwon;
  bool get isProfilePage => _selectedPage == PageName.profile && !isUnkwon;
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    currentConfiguration;
  }

  PageName? pageName;
  bool show404 = false;

  AppRoutePath get currentConfiguration {
    if (show404) {
      return AppRoutePath.unknown();
    }

    if (pageName == null) return AppRoutePath.home();
    if (pageName == PageName.setting) return AppRoutePath.setting();
    if (pageName == PageName.profile) return AppRoutePath.profile();

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
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        pageName = null;
        show404 = false;
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
    }
    if (configuration.isHomePage) {
      show404 = false;
      pageName = null;
    }

    if (configuration.isSettingPage) {
      show404 = false;
      pageName = PageName.setting;
    }

    if (configuration.isProfilePage) {
      show404 = false;
      pageName = PageName.profile;
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
