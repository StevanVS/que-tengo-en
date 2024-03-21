import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injector/injector.dart';

import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/injection/injection.dart';
import 'package:que_tengo_en/ui/pages/lista_lugares/lista_lugares_page.dart';
import 'package:que_tengo_en/ui/utils/theme_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await RepositoriesRegister().register();
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
          create: (context) => Injector.appInstance.get<PertenenciaBloc>()
            ..add(const SubscribePertenenciasStream()),
        ),
        BlocProvider(
          create: (context) => Injector.appInstance.get<LugarBloc>()
            ..add(const SubscribeLugaresStream()),
        ),
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
      home: const ListaLugaresPage(),
    );
  }
}
