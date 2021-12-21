import 'package:flutter/material.dart';
import 'package:kino/domain/data_provides/session_data_provider.dart';
import 'package:kino/resources/resources.dart';
import 'package:kino/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onselectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppImages.logo),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [const Text('News'), MovieListWidget(), const Text('Serials')],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Новости'),
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
              icon: const Icon(Icons.movie_filter), label: 'Филмы'),
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Сериалы')
        ],
        onTap: onselectTab,
      ),
    );
  }
}
