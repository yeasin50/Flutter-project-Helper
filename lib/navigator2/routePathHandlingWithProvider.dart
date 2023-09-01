import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PageNotifier>(
          create: (context) => PageNotifier(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate: AppRouterDelegate(
        Provider.of<PageNotifier>(context),
      ),
      title: 'Flutter Navigator2 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class AppRoutePath {
  String _pageName = '/';
  bool _showError = false;

  AppRoutePath.home()
      : _pageName = '/',
        _showError = false;

  AppRoutePath.setting()
      : _pageName = '/setting',
        _showError = false;

  AppRoutePath.profile()
      : _pageName = '/profile',
        _showError = false;

  AppRoutePath.unKnown()
      : _pageName = "/404",
        _showError = true;

  get isHome => _pageName == '/' && !_showError;
  get isSetting => _pageName == '/setting' && !_showError;
  get isProfile => _pageName == '/profile' && !_showError;
  get isUnknown => _showError == true && _pageName == '/404';
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');

    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.home();
    }
    if (uri.pathSegments[0] == 'setting') {
      return AppRoutePath.setting();
    }
    if (uri.pathSegments[0] == 'profile') {
      return AppRoutePath.profile();
    }

    return AppRoutePath.unKnown();
  }

  // @override
  // AppRouteInformationParser get currentConfiguration => {};

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(location: '/404');
    }

    if (configuration.isSetting) {
      return RouteInformation(location: '/setting');
    }
    if (configuration.isProfile) {
      return RouteInformation(location: '/profile');
    }
    if (configuration.isHome) return RouteInformation(location: '/');
  }
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final PageNotifier notifier;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate(this.notifier)
      : navigatorKey = GlobalKey<NavigatorState>() {
    currentConfiguration;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (notifier.isUnknown)
          const MaterialPage(
            child: WrapperX(
              child: Center(
                child: Text("ErrorPage"),
              ),
            ),
          ),
        if (notifier.pageName == '/')
          const MaterialPage(
            child: WrapperX(
              child: Center(child: Text("Home")),
            ),
          ),
        if (notifier.pageName == '/setting')
          const MaterialPage(
            child: WrapperX(
              child: Center(child: Text("setting")),
            ),
          ),
        if (notifier.pageName == '/profile')
          const MaterialPage(
            child: WrapperX(
              child: Center(child: Text("Profile")),
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        notifier.changeScreen(pageName: '/');
        notifyListeners();
        return true;
      },
    );
  }

  @override
  AppRoutePath? get currentConfiguration {
    if (notifier.isUnknown) return AppRoutePath.unKnown();
    if (notifier.pageName == '/') return AppRoutePath.home();
    if (notifier.pageName == '/profile') return AppRoutePath.profile();
    if (notifier.pageName == '/setting') return AppRoutePath.setting();
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isUnknown) {
      notifier.changeScreen(pageName: '/404', unkwon: true);
    }

    if (configuration.isHome) {
      notifier.changeScreen(pageName: '/');
    }
    if (configuration.isSetting) {
      notifier.changeScreen(pageName: '/setting');
    }
    if (configuration.isProfile) {
      notifier.changeScreen(pageName: '/profile');
    }
  }
}

class PageNotifier extends ChangeNotifier {
  String _pageName = '/';
  bool _isUnknownPage = false;

  void changeScreen({required String pageName, bool unkwon = false}) {
    _pageName = pageName;
    _isUnknownPage = unkwon;
    notifyListeners();

    print(_pageName);
  }

  get pageName => _pageName;
  get isUnknown => _isUnknownPage;
}

class WrapperX extends StatelessWidget {
  final Widget child;

  const WrapperX({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          child,
          const ButtonsH(),
        ],
      ),
    );
  }
}

class ButtonsH extends StatelessWidget {
  const ButtonsH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(
      context,
    );
    return Row(
      children: [
        TextButton(
            onPressed: () {
              notifier.changeScreen(pageName: '/');
            },
            child: const Text("Home")),
        TextButton(
            onPressed: () {
              notifier.changeScreen(pageName: '/profile');
            },
            child: const Text("Profile")),
        TextButton(
            onPressed: () {
              notifier.changeScreen(pageName: '/setting');
            },
            child: const Text("Setting")),
      ],
    );
  }
}
