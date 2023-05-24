import 'package:btictao/games/tictactoa.dart';
import 'package:btictao/provider/tictacstateprovider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'provider/darkmodesettingprovider.dart';
import 'provider/playersettingprovider.dart';
import 'provider/soundeffectsettingprovider.dart';
import 'screen/transparentmodal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TicTacStateProvider>(
            create: (context) => TicTacStateProvider()),
        ChangeNotifierProvider<DarkModeSettingProvider>(
            create: (context) => DarkModeSettingProvider()),
        ChangeNotifierProvider<PlayerSettingProvider>(
          create: ((context) => PlayerSettingProvider()),
        ),
        ChangeNotifierProvider<SoundEffectSettingProvider>(
          create: ((context) => SoundEffectSettingProvider()),
        )
      ],
      child: Consumer<DarkModeSettingProvider>(
        builder: ((context, provider, child) => MaterialApp(
              title: 'Flutter Demo',
              themeMode: provider.isDarkModeEnabled()
                  ? ThemeMode.dark
                  : ThemeMode.light,
              darkTheme: ThemeData.dark(),
              theme: ThemeData(
                  primarySwatch: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(.2)),
              home: TicTacToa(),
            )),
      ),
    );
  }
}
