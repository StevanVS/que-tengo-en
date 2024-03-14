import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/pages/lista_pertenencias/lista_pertenencias_page.dart';
import 'package:que_tengo_en/ui/theme_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Que tengo en',
      darkTheme: ThemeApp.theme(darkTheme: true),
      theme: ThemeApp.theme(),
      themeMode: ThemeMode.system,
      home: ListaPertenenciasPage(lugar: Lugar(id: 1, nombre: 'Portoviejo')),
    );
  }
}
