import 'package:fluro/fluro.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_agriculture_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture_v2/screens/authentication_screen/login_screen.dart';
import 'package:smart_agriculture_v2/screens/authentication_screen/otp_screen.dart';
import 'package:smart_agriculture_v2/stores/auth_store/auth_store.dart';
import 'package:smart_agriculture_v2/stores/user_store/user_store.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = "/";
  static const String register = "/register";
  static const String otp = "/otp";
}

FluroRouter config() {
  final router = FluroRouter();

  router.define(
    AppRoutes.home,
    handler: Handler(
      handlerFunc: (context, param) => AuthGuardWidget(
        widget: Consumer<UserStore>(
          builder: (context, userStore, _) {
            return InitialScreen(
              userStore: userStore,
            );
          },
        ),
      ),
    ),
    transitionType: TransitionType.native,
  );

  // router.define(AppRoutes.otp, handler: Handler(
  //   handlerFunc: (context, param) {
  //     return Consumer<AuthStore>(builder: (context, authStore, _) {
  //       return OTPScreen(
  //         authStore: authStore,
  //       );
  //     });
  //   },
  // ), transitionType: TransitionType.native);

  return router;
}

class AuthGuardWidget extends StatefulWidget {
  const AuthGuardWidget({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  State<AuthGuardWidget> createState() => _AuthGuardWidgetState();
}

class _AuthGuardWidgetState extends State<AuthGuardWidget> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthStore>(context);
    return Observer(builder: (context) {
      print("auth.isLogin: ${auth.isLogin}");
      return Visibility(
        visible: auth.isLogin || true,
        replacement: LoginScreen(
          authStore: auth,
        ),
        child: widget.widget,
      );
    });
  }
}
