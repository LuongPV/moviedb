import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/constants.dart';
import '../search/search_widget.dart';
import '../theater/nearby_theaters_widget.dart';
import 'home_bloc.dart';
import 'home_movies/home_movies_widget.dart';
import 'home_settings/home_settings_widget.dart';
import 'home_states.dart';
import 'home_trend/home_trendings_widget.dart';
import 'home_tv_shows/home_tv_shows_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool isConfirmExit = false;
  bool _isDelayingExit = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> _pages = _buildMainPages();
  final List<BottomNavigationBarItem> _bottomItems =
      _buildBottomNavigationBarItems();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(RepositoryProvider.of(context)),
      child: Builder(builder: (context) {
        return BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case HomeConfirmExitLoaded:
                setState(() {
                  isConfirmExit =
                      (state as HomeConfirmExitLoaded).isConfirmExit;
                });
                break;
            }
            isConfirmExit = false;
          },
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(
                  _bottomItems[_selectedIndex].label!,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              drawer: _buildNavigationDrawer(),
              body: IndexedStack(
                children: _pages,
                index: _selectedIndex,
              ),
              bottomNavigationBar: _buildBottomNavigationBar(),
            ),
          ),
        );
      }),
    );
  }

  Future<bool> _onWillPop() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.pop(context);
      return Future.value(false);
    }
    if (isConfirmExit) {
      return Future.value(true);
    }
    if (!_isDelayingExit) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: delayConfirmExitSec),
        content: Text(
          "Press 'Back' again to exit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue,
      ));
      _isDelayingExit = true;
      Future.delayed(const Duration(seconds: delayConfirmExitSec))
          .then((_) => _isDelayingExit = false);
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
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      onTap: _onIndexChanged,
      items: _bottomItems,
    );
  }

  static List<Widget> _buildMainPages() {
    return [
      const HomeTrendingsWidget(),
      const HomeMoviesWidget(),
      const HomeTVShowsWidget(),
      const HomeSettingsWidget(),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x0D2196F3), Color(0xDD2196F3), Color(0x0D2196F3)],
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              child: SizedBox(
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
            _buildLeftMenuItem(
                Icons.search_outlined,
                'Search',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SearchWidget()))),
            _buildLeftMenuItem(
                Icons.trending_up, 'Trend', () => _selectedIndex = 0),
            _buildLeftMenuItem(Icons.movie, 'Movie', () => _selectedIndex = 1),
            _buildLeftMenuItem(
                Icons.live_tv_sharp, 'TV Show', () => _selectedIndex = 2),
            _buildLeftMenuItem(
                Icons.settings, 'Settings', () => _selectedIndex = 3),
            _buildLeftMenuItem(
                Icons.theaters,
                'Nearby Theaters',
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const NearbyTheatersWidget()))),
            const Expanded(child: Material()),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) => Visibility(
                visible: state is HomeAppVersionLoaded,
                child:
                    Text('Version: ${(state as HomeAppVersionLoaded).version}'),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  ListTile _buildLeftMenuItem(
      IconData iconData, String label, Function clickListener) {
    return ListTile(
      leading: Icon(
        iconData,
        color: const Color(0xFFDAE9FF),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFFDAE9FF),
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          clickListener();
        });
      },
    );
  }
}
