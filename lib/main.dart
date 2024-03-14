import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

import 'package:que_tengo_en/domain/bloc/bloc.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/injection/blocs_register.dart';
import 'package:que_tengo_en/ui/pages/lista_pertenencias/lista_pertenencias_page.dart';
import 'package:que_tengo_en/ui/theme_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BlocsRegister();

  runApp(const BlocsProvider());
}

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Injector.appInstance.get<PertenenciaBloc>(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Que tengo en',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeApp.theme(darkTheme: true),
      theme: ThemeApp.theme(),
      themeMode: ThemeMode.system,
      home: ListaPertenenciasPage(lugar: Lugar(id: 1, nombre: 'Portoviejo')),
    );
  }
}
