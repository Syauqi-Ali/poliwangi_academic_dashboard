import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

class Modul03App extends StatelessWidget {
  const Modul03App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'KRS & State Management TRPL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
          useMaterial3: true,
        ),
        routerConfig: modul03Router,
      ),
    );
  }
}
