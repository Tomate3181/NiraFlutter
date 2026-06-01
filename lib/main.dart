import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';
import 'screens/conteudos_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/como_funciona_screen.dart';
import 'screens/sobre_screen.dart';

// ── Brand palette (alinhada com o site React) ──────────────────────────────
const kBrandPrimary   = Color(0xFF8B7EFA); // roxo principal
const kBgMain         = Color(0xFF11111B); // fundo escuro
const kBgAlt          = Color(0xFF181825); // nav bar / superfícies elevadas
const kBgSecondary    = Color(0xFF1E1E2E); // cards / seções alternadas
const kBorder         = Color(0xFF2B2B3C); // bordas sutis
const kTextMuted      = Color(0xFFA6A6B0); // texto secundário
const kEmergency      = Color(0xFFE53E3E); // vermelho SOS

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Força a barra de status transparente para integrar com o fundo escuro
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: kBgAlt,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  String supabaseUrl = const String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  String supabaseAnonKey = const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');
  String geminiApiKey = const String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

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
        : (dotenv.env['VITE_SUPABASE_ANON_KEY'] ?? dotenv.env['SUPABASE_ANON_KEY'] ?? '');
    geminiApiKey = geminiApiKey.isNotEmpty
        ? geminiApiKey
        : (dotenv.env['VITE_GEMINI_API_KEY'] ?? dotenv.env['GEMINI_API_KEY'] ?? '');
  }

  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  } else {
    debugPrint('SUPABASE_URL or SUPABASE_ANON_KEY not provided; Supabase not initialized.');
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
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: kBrandPrimary,
          secondary: kBrandPrimary,
          surface: kBgSecondary,
          error: kEmergency,
        ),
        scaffoldBackgroundColor: kBgMain,
        // Garante que diálogos e bottom sheets usem a paleta correta
        dialogTheme: const DialogThemeData(backgroundColor: kBgSecondary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kBrandPrimary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// MainScaffold — Bottom Navigation Bar
// ══════════════════════════════════════════════════════════════════════════════
class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({required this.child, super.key});

  static const _navItems = <_NavItem>[
    _NavItem(label: 'Início',     icon: Icons.home_rounded,       path: '/'),
    _NavItem(label: 'Conteúdos', icon: Icons.menu_book_rounded,  path: '/conteudos'),
    _NavItem(label: 'Chat',       icon: Icons.chat_bubble_rounded, path: '/chat'),
    _NavItem(label: 'Sobre',      icon: Icons.info_rounded,       path: '/sobre'),
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
      backgroundColor: kBgMain,
      body: SafeArea(child: child),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: kBgAlt,
          border: Border(top: BorderSide(color: kBorder, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: selected,
          onTap: (idx) => GoRouter.of(context).go(_navItems[idx].path),
          backgroundColor: Colors.transparent,
          selectedItemColor: kBrandPrimary,
          unselectedItemColor: kTextMuted,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: _navItems
              .map(
                (it) => BottomNavigationBarItem(
                  icon: Icon(it.icon),
                  label: it.label,
                ),
              )
              .toList(),
        ),
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
