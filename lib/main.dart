import 'package:flutter/material.dart';
import 'package:kino/widgets/my_app_model.dart';
import 'package:kino/widgets/navigation/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  final app = MyApp(model: model);
  runApp(app);
}

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final mainNavigation = MainNavigation();
  MyApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kino demo',
      theme: ThemeData(
          appBarTheme:
              const AppBarTheme(backgroundColor: Color.fromRGBO(3, 37, 65, 1)),
          // ignore: prefer_const_constructors
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey)),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
