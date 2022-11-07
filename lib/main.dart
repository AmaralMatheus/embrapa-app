import 'package:embrapa/colors.dart';
import 'package:embrapa/screens/cultivar/cultivar.dart';
import 'package:embrapa/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/cultivar/cultivares.dart';
import 'screens/profile/profile.dart';
import 'widgets/transition.dart';
import 'screens/splash/splash.dart';
import 'screens/initial/initial.dart';
import 'screens/register/register.dart';
import 'screens/home/home.dart';
import 'screens/weather/weather.dart';
import 'screens/comparsion/comparsion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper(this.child);

  Widget _sizeBuilder(BuildContext context, BoxConstraints constraints) =>
      this.child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: this._sizeBuilder,
      );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routes = <String, WidgetBuilder>{
    'splash': (context) => Wrapper(SplashScreen()),
    'initial': (context) => Wrapper(InitialScreen()),
    'register': (context) => Wrapper(RegisterScreen()),
    'home': (context) => Wrapper(HomeScreen()),
    'weather': (context) => Wrapper(WeatherScreen()),
    'profile': (context) => Wrapper(ProfileScreen()),
    'cultivar': (context) => Wrapper(CultivarScreen()),
    'cultivares': (context) => Wrapper(CultivaresScreen()),
    'comparsion': (context) => Wrapper(ComparsionScreen()),
    'dashboard': (context) => Wrapper(DashboardScreen()),
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Embrapa',
      theme: ThemeData(fontFamily: 'Gilroy', canvasColor: Colors.white, primaryColor: Palette.primary, textTheme: TextTheme(
        body1: TextStyle(
          color: WidgetsBinding.instance.window.platformBrightness == Brightness.light ? Colors.black : Colors.white
        ),
      )),
      initialRoute: 'splash',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => CustomTransition(
        settings: settings,
        builder: this._routes[settings.name],
      ),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(
      //     analytics: this._analytics,
      //     onError: (error) => print('$error'),
      //   ),
      // ],
      supportedLocales: [
        const Locale('pt', 'BR'),
        // const Locale('en', 'US'),
        // const Locale('eu', 'ES')
      ],
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}