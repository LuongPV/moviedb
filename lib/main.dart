import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'data/apis/account_api.dart';
import 'data/prefs/account_prefs.dart';
import 'data/repositories/account_repository_impl.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'data/services/fcm/firebase_cloud_message.dart';
import 'domain/repositories/settings_repository.dart';
import 'presentation/features/shared_blocs/auth/auth_bloc.dart';
import 'presentation/features/ui/splash/splash_widget.dart';

void main() {
  initCloudMessageService();
  final accountAPI = AccountAPI();
  final accountPref = AccountPrefs();
  final accountRepository = AccountRepositoryImpl(accountAPI, accountPref);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SettingsRepository>.value(value: SettingsRepositoryImpl())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: AuthBloc(accountRepository)),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieDB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'montserrat',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashWidget(),
    );
  }
}
