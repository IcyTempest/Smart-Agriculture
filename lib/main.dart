import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_agriculture_v2/configs/color_config.dart';
import 'package:smart_agriculture_v2/routes.dart';
import 'package:smart_agriculture_v2/screens/eletric_screen/eletric_screen.dart';
import 'package:smart_agriculture_v2/screens/home_screen/home_screen.dart';
import 'package:smart_agriculture_v2/screens/setting_screen/setting_screen.dart';
import 'package:smart_agriculture_v2/screens/user_screen/user_screen.dart';
import 'package:smart_agriculture_v2/stores/auth_store/auth_store.dart';
import 'package:smart_agriculture_v2/stores/user_store/user_store.dart';
import 'firebase_options.dart';
import 'routes.dart' as routes;

final router = routes.config();

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserStore>(
          create: (context) => UserStore(),
        ),
        ProxyProvider<UserStore, AuthStore>(
          update: (context, userStore, _) => AuthStore(userStore: userStore),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: router.generator,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: ColorConfig.background,

        ),
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {

  const InitialScreen({Key? key, required this.userStore}) : super(key: key);
  final UserStore userStore;
  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;

  // final PageController pageController = PageController();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();


  late final  List<Widget> _widget = <Widget>[
    HomeScreen(globalKey: globalKey, userStore: widget.userStore,),
    ElectricScreen(),
    UserScreen(),
    SettingScreen(userStore: widget.userStore,),
  ];

  @override
  void dispose() {
    // pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: _widget[_selectedIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: ColorConfig.background,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavyBarItem(icon: Icon(Icons.home_filled), title: Text("Home")),
          BottomNavyBarItem(icon: Icon(Icons.light_outlined), title: Text("Electric")),
          BottomNavyBarItem(icon: Icon(Icons.person), title: Text("User")),
          BottomNavyBarItem(icon: Icon(Icons.settings), title: Text("Setting")),
        ],
      ),
    );
  }
}
