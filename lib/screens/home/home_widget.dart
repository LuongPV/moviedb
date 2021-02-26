import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/home/home_movie_widget.dart';
import 'package:movie_db/screens/home/home_settings_widget.dart';
import 'package:movie_db/screens/home/home_trend_widget.dart';
import 'package:movie_db/screens/home/home_tv_show_widget.dart';

class HomeWidget extends BaseStatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<MovieGeneral> movies;
  int _selectedIndex = 0;
  final _movieRepository = MovieRepository();
  List<Widget> _pages = _buildMainPages();
  List<BottomNavigationBarItem> _bottomItems = _buildBottomNavigationBarItems();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _bottomItems[_selectedIndex].label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ),
      body: Container(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
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
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.trending_up),
        label: 'Trend',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.movie),
        label: 'Movie',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.live_tv_sharp),
        label: 'TV Show',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];
  }
}
