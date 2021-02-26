import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/home/home_movie_widget.dart';
import 'package:movie_db/screens/home/home_settings_widget.dart';
import 'package:movie_db/screens/home/home_trend_widget.dart';
import 'package:movie_db/screens/home/home_tv_show_widget.dart';
import 'package:movie_db/utils/package_info.dart';

class HomeWidget extends BaseStatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var canExit = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<MovieGeneral> movies;
  int _selectedIndex = 0;
  List<Widget> _pages = _buildMainPages();
  List<BottomNavigationBarItem> _bottomItems = _buildBottomNavigationBarItems();
  var versionName;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getVersionName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(_bottomItems[_selectedIndex].label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        drawer: _buildNavigationDrawer(),
        body: Container(
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (scaffoldKey.currentState.isDrawerOpen) {
      Navigator.pop(context);
      return Future.value(false);
    }
    if (!canExit) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Press 'Back' again to exit",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ));
      canExit = true;
      Future.delayed(Duration(seconds: 3)).then((_) => canExit = false);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      onTap: _onIndexChanged,
      items: _bottomItems,
    );
  }

  static List<Widget> _buildMainPages() {
    return [
      HomeTrendWidget(),
      HomeMovieWidget(),
      HomeTVShowWidget(),
      HomeSettingsWidget(),
    ];
  }

  static List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    BottomNavigationBarItem _buildItem(IconData iconData, String label) =>
        BottomNavigationBarItem(
          icon: Icon(iconData),
          label: label,
        );
    return [
      _buildItem(Icons.trending_up, 'Trend'),
      _buildItem(Icons.movie, 'Movie'),
      _buildItem(Icons.live_tv_sharp, 'TV Show'),
      _buildItem(Icons.settings, 'Settings'),
    ];
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x0D2196F3), Color(0xDD2196F3), Color(0x0D2196F3)],
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                height: 200,
                child: Center(
                  child: Image.asset(
                    'assets/images/ic_logo.png',
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            _buildLeftMenuItem(Icons.movie, 'Movie', 1),
            _buildLeftMenuItem(Icons.live_tv_sharp, 'TV Show', 2),
            _buildLeftMenuItem(Icons.settings, 'Settings', 3),
            Expanded(child: Material()),
            Text('Version: $versionName'),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  ListTile _buildLeftMenuItem(IconData iconData, String label, int index) {
    return ListTile(
          leading: Icon(iconData),
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onTap: () {
            setState(() {
              Navigator.pop(context);
              _selectedIndex = index;
            });
          },
        );
  }

  void _getVersionName() {
    getVersionName().then((value) {
      setState(() {
       versionName = value;
      });
    });
  }
}