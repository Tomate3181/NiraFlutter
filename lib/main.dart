import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/conteudos_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/como_funciona_screen.dart';
import 'screens/sobre_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: '/', name: 'home', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/conteudos', name: 'conteudos', builder: (context, state) => const ConteudosScreen()),
          GoRoute(path: '/chat', name: 'chat', builder: (context, state) => const ChatScreen()),
          GoRoute(path: '/como', name: 'como', builder: (context, state) => const ComoFuncionaScreen()),
          GoRoute(path: '/sobre', name: 'sobre', builder: (context, state) => const SobreScreen()),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NIRA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({required this.child, super.key});

  static const _navItems = <_NavItem>[
    _NavItem(label: 'Início', icon: Icons.home, path: '/'),
    _NavItem(label: 'Conteúdos', icon: Icons.menu_book, path: '/conteudos'),
    _NavItem(label: 'Chat', icon: Icons.chat, path: '/chat'),
    _NavItem(label: 'Sobre', icon: Icons.info, path: '/sobre'),
  ];

  int _selectedIndex(BuildContext context) {
    final location = GoRouter.of(context).location;
    for (var i = 0; i < _navItems.length; i++) {
      final p = _navItems[i].path;
      if (p == '/') {
        if (location == '/') return i;
      } else if (location.startsWith(p)) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedIndex(context);

    return Scaffold(
      backgroundColor: const Color(0xFF07070B),
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,
        onTap: (idx) => GoRouter.of(context).go(_navItems[idx].path),
        backgroundColor: const Color(0xFF0B0B10),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: _navItems.map((it) => BottomNavigationBarItem(icon: Icon(it.icon), label: it.label)).toList(),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String path;
  const _NavItem({required this.label, required this.icon, required this.path});
}
