import 'package:fluro/fluro.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:web_test/model/arguments.dart';
import 'package:web_test/screens/home.dart';
import 'package:web_test/screens/settings.dart';
import 'package:web_test/screens/user_profile.dart';
import 'package:web_test/screens/users_details.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../body.dart';

class Routes {
  static final FluroRouter router = FluroRouter();

  static String root = "/";
  static String user = "/user";
  static String home = "/home";
  static String settings = "/settings";
  static String userDetails = "/user/:username";

  static Handler _homeScreen = Handler(
    handlerFunc: (context, parameters) => HomeScreen(),
  );
  static Handler _home2Screen = Handler(
    handlerFunc: (context, parameters) => Home2Screen(),
  );

  static Handler _settingScreen = Handler(
    handlerFunc: (context, parameters) => SettingScreen(),
  );

  static Handler _profileScreen = Handler(
    handlerFunc: (context, parameters) {
      // print(parameters.toString());
      // Map<String, dynamic> param = parameters;
      // final int data = int.parse((param['id'][0]).toString().substring(1));

      return UserProfileScreen(param: parameters);
    },
  );

  static Handler _userDetails = Handler(
    handlerFunc: (context, parameters) {
      List<ScreenArguments> args = [];

      Map<String, dynamic> _param = parameters;

      _param.forEach((key, value) {
        args.add(ScreenArguments(key, value[0]));
      });

      final userData =
          args.firstWhere((element) => element.title == "username");

      ///getting userNameFrom route
      String userName = userData.message.contains(":")
          ? userData.message.replaceFirst(":", "")
          : userData.message;

      return UserDetails(
        userName: userName,
      );
    },
  );

  static void configureRoutes(FluroRouter router) {
    router.define(
      root,
      handler: _homeScreen,
    );

    router.define(
      home,
      handler: _homeScreen,
    );

    router.define(
      home,
      handler: _home2Screen,
    );

    router.define(
      settings,
      handler: _settingScreen,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      "/users/:id",
      handler: _profileScreen,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      userDetails,
      handler: _userDetails,
    );
  }
}
