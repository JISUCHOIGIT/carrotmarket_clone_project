import 'package:carrotmarket_clone/page/home.dart';
import 'package:carrotmarket_clone/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentPageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/svg/${iconName}_off.svg',
          width: 22,
        ),
      ),
      activeIcon:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/svg/${iconName}_on.svg',
          width: 22,
        ),
      ),
      label: label,
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        print(index);
        setState(() {
          _currentPageIndex = index;
        });
      },
      currentIndex: _currentPageIndex,
      selectedFontSize: 12.0,
      selectedItemColor: Colors.black,
      items: [
        _bottomNavigationBarItem('home', '홈'),
        _bottomNavigationBarItem('notes', '동네생활'),
        _bottomNavigationBarItem('location', '내 근처'),
        _bottomNavigationBarItem('chat', '채팅'),
        _bottomNavigationBarItem('user', '나의 당근'),
      ],
    );
  }

  Widget? _body() {
    switch(_currentPageIndex) {
      case 0:
        return HomePage();
        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      case 4:
        return Container();
        break;
    }
  }

}
