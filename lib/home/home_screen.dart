import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_app/home/dashboard_screen.dart';
import 'package:crud_app/home/profile_screen.dart';
import 'package:crud_app/home/settings_screen.dart';
import 'package:crud_app/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal logout: ${e.toString()}', style: const TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Aplikasi'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: theme.colorScheme.onPrimary),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
        backgroundColor: theme.colorScheme.primary,  
        foregroundColor: theme.colorScheme.onPrimary,  
        elevation: 4, 
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    selectedIconTheme: IconThemeData(color: theme.colorScheme.primary),
                    unselectedIconTheme: IconThemeData(color: theme.colorScheme.onSurface.withOpacity(0.6)),
                    selectedLabelTextStyle: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                    unselectedLabelTextStyle: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6)),
                    backgroundColor: theme.colorScheme.surface, 
                    destinations: const <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: Text('Dashboard'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: Text('Profil'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: Text('Pengaturan'),
                      ),
                    ],
                  ),
                  VerticalDivider(thickness: 1, width: 1, color: theme.dividerColor),
                  Expanded(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  ),
                ],
              );
            } else {
              return _widgetOptions.elementAt(_selectedIndex);
            }
          },
        ),
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return const SizedBox.shrink();
          } else {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Pengaturan',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: theme.colorScheme.surface,
              elevation: 8,
              selectedLabelStyle: AppStyles.smallBodyStyle.copyWith(fontWeight: FontWeight.bold),
              unselectedLabelStyle: AppStyles.smallBodyStyle,
            );
          }
        },
      ),
    );
  }
}