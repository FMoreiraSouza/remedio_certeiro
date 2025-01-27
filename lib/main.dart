import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/providers.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/app_theme.dart';
import 'package:remedio_certeiro/utils/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService.init();

  // Verifica se há um sessionId salvo
  final sessionId = SharedPreferencesService.getString('sessionId');

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MyApp(sessionId: sessionId),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? sessionId;

  const MyApp({super.key, this.sessionId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getTheme(),
      onGenerateTitle: (context) {
        return 'Remédio Certeiro';
      },
      initialRoute: sessionId != null ? ScreensRoutes.home : ScreensRoutes.login,
      routes: getRoutes(),
    );
  }
}
