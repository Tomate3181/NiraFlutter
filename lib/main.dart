import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';
import 'screens/conteudos_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/como_funciona_screen.dart';
import 'screens/sobre_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Primeiro, tentamos obter valores passados em tempo de compilação via
  // --dart-define. Se não existirem, carregamos o arquivo .env (se presente)
  // usando `flutter_dotenv`.
  String supabaseUrl = const String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );
  String supabaseAnonKey = const String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );
  String geminiApiKey = const String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty || geminiApiKey.isEmpty) {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // Ignore if .env is missing — we'll handle empties below.
    }

    supabaseUrl = supabaseUrl.isNotEmpty
        ? supabaseUrl
        : (dotenv.env['VITE_SUPABASE_URL'] ?? dotenv.env['SUPABASE_URL'] ?? '');
    supabaseAnonKey = supabaseAnonKey.isNotEmpty
        ? supabaseAnonKey
        : (dotenv.env['VITE_SUPABASE_ANON_KEY'] ??
              dotenv.env['SUPABASE_ANON_KEY'] ??
              '');
    geminiApiKey = geminiApiKey.isNotEmpty
        ? geminiApiKey
        : (dotenv.env['VITE_GEMINI_API_KEY'] ??
              dotenv.env['GEMINI_API_KEY'] ??
              '');
  }

  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  } else {
    debugPrint(
      'SUPABASE_URL or SUPABASE_ANON_KEY not provided; Supabase not initialized.',
    );
  }

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
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/conteudos',
            name: 'conteudos',
            builder: (context, state) => const ConteudosScreen(),
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final sos = extra?['sos'] == true;
              final start = extra?['start'] == true;
              return ChatScreen(startWithSos: sos, startChat: start);
            },
          ),
          GoRoute(
            path: '/como',
            name: 'como',
            builder: (context, state) => const ComoFuncionaScreen(),
          ),
          GoRoute(
            path: '/sobre',
            name: 'sobre',
            builder: (context, state) => const SobreScreen(),
          ),
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
        items: _navItems
            .map(
              (it) =>
                  BottomNavigationBarItem(icon: Icon(it.icon), label: it.label),
            )
            .toList(),
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
