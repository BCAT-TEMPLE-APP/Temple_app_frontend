import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_app/core/provider/theme_provider.dart';
import 'package:flutter_user_app/features/auth/login/presentation/screens/login_page.dart';
import 'package:flutter_user_app/core/util/theme_scheme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure Flutter is initialized and preserve splash screen
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize theme provider with saved preferences
  final themeProvider = await ThemeProvider.initialize();

  // Run the app
  runApp(
    ChangeNotifierProvider<ThemeProvider>.value(
      value: themeProvider,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Future for handling initialization tasks
  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    // Define initialization tasks that need to complete before removing splash
    _initializationFuture = _initializeApp();
  }

  // Handle all initialization tasks here
  Future<void> _initializeApp() async {
    // Perform any necessary startup operations here:
    // - Load configurations
    // - Initialize services
    // - Fetch initial data
    // - Check authentication state

    // Example initialization tasks (replace with your actual needs)
    await Future.wait([
      // Example: Initialize services
      Future.delayed(
          const Duration(milliseconds: 500)), // Simulating service init

      // Minimum splash display time (only if needed - consider removing)
      // This ensures splash shows for at least this duration
      Future.delayed(const Duration(seconds: 1)),
    ]);

    // Remove splash screen once everything is ready
    FlutterNativeSplash.remove();
  }

  // Update system UI based on current theme
  void _updateSystemUI(ThemeMode mode) {
    final isDark = mode == ThemeMode.dark ||
        (mode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? Colors.black : Colors.white,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      // Update system UI whenever theme changes
      _updateSystemUI(themeProvider.themeMode);

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeProvider.themeMode,
        themeAnimationDuration: const Duration(milliseconds: 600),
        themeAnimationCurve: Curves.easeInOutCirc,
        // Use FutureBuilder to transition from splash to app content
        home: FutureBuilder<void>(
          future: _initializationFuture,
          builder: (context, snapshot) {
            // Show actual app content when initialization is complete
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginPage();
            }

            // During initialization, show a minimal loading widget
            // The native splash is still visible during this time
            return const SizedBox.shrink();
          },
        ),
      );
    });
  }
}
