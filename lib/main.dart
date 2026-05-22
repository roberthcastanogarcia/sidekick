import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'core/routing/main_navigation.dart';

void main() {
  // Aseguramos que los bindings de Flutter estén inicializados para usar sqflite_ffi
  WidgetsFlutterBinding.ensureInitialized();

  // Si estamos en Linux o Windows, iniciamos el adaptador FFI
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const SidekickApp());
}

class SidekickApp extends StatelessWidget {
  const SidekickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidekick',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Apuntamos al archivo extraído
      home: const MainNavigation(),
    );
  }
}