// https://gist.github.com/yeasin50/234d8e3b06d9356e3484023f7db2872f



main() {
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  // Hive.init(appDocumentDir.path);
  // Hive.registerAdapter(UserAdapter());

  runApp(MyApp());
}

class AppRoutePath {
  int? id;
  final bool isUnkwon;
  final bool beyondlist;

  AppRoutePath.home()
      : id = null,
        isUnkwon = false,
        beyondlist = false;

  AppRoutePath.details(this.id)
      : isUnkwon = false,
        beyondlist = false;

  AppRoutePath.unknown()
      : id = null,
        isUnkwon = true,
        beyondlist = false;

  bool get isHomePage => id == null;
  bool get isDetailsPage => id != null;
  bool get isBeyondList => beyondlist;
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  int? _selectedItem;
  bool show404 = false;

  AppRoutePath get currentConfiguration {
    if (show404) {
      return AppRoutePath.unknown();
    }

    return _selectedItem == null
        ? AppRoutePath.home()
        : AppRoutePath.details(_selectedItem);
  }

  void _handleSelection(int index) {
    _selectedItem = index;
    notifyListeners();
    print("index $index");
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          child: HomeScreen(
            onTap: _handleSelection,
          ),
        ),
        if (show404)
          MaterialPage(
            child: ErrorScreen(),
          ),
        if (_selectedItem != null)
          _selectedItem! > maxItem || _selectedItem! < 0
              ? MaterialPage(
                  child: UnknownScreen(),
                )
              : MaterialPage(
                  key: ValueKey('details'),
                  child: DetailsScreen(
                    index: _selectedItem!,
                  ),
                )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _selectedItem = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isUnkwon) {
      _selectedItem = null;
      show404 = true;
      return;
    }

    if (configuration.isDetailsPage) {
      if (configuration.id! < 0 || configuration.id! > maxItem - 1) {
        show404 = true;
      }

      _selectedItem = configuration.id;
    } else {
      _selectedItem = null;
    }
    show404 = false;
  }
}

/// RouteInformationParser
class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    ///* handle '/'
    if (uri.pathSegments.length == 0) {
      return AppRoutePath.home();
    }

    ///* handle `/details:id`
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'details') return AppRoutePath.unknown();

      final id = int.tryParse(uri.pathSegments[1]);
      if (id == null) return AppRoutePath.unknown();
      return AppRoutePath.details(id);
    }

    ///* `unkwon route`
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnkwon) return RouteInformation(location: '/404');
    if (configuration.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/details/${configuration.id}');
    }

    return null;
  }
}

int maxItem = 12;

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
