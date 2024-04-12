import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:pp71/core/config/injection.dart';
import 'package:pp71/core/routes/routes.dart';
import 'package:pp71/core/theme/theme.dart';
import 'package:pp71/feature/view/home/pages/customers_view.dart';
import 'package:pp71/feature/view/home/pages/home_view.dart';
import 'package:pp71/feature/view/home/pages/new_cleint.dart';
import 'package:pp71/feature/view/home/pages/new_order.dart';
import 'package:pp71/feature/view/home/pages/new_order2.dart';
import 'package:theme_provider/theme_provider.dart';

Future<void> main() async {
  // final widgetsBinding =
   WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _initApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(AppInfo(
    data: await AppInfoData.get(),
    child: const MealPlaner(),
  ));
}

Future<void> _initApp() async {
  // try {
  //   await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  //   FlutterError.onError = (errorDetails) {
  //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //   };
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     return true;
  //   };
  // } on Exception catch (e) {
  //   log("Failed to initialize Firebase: $e");
  // }
  await ServiceLocator.setup();
}

class MealPlaner extends StatelessWidget {
  const MealPlaner({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    // MultiBlocProvider(
    //   providers: [
    //     // BlocProvider(create: (context) => GetIt.instance<ItemBloc>()),
    //   ],
    //   child: 
      ThemeProvider(
        defaultThemeId: DefaultTheme.dark.id,
        saveThemesOnChange: true,
        onInitCallback: (controller, previouslySavedThemeFuture) async {
          String? savedTheme = await previouslySavedThemeFuture;
          if (savedTheme != null) {
            controller.setTheme(savedTheme);
          }
        },
        themes: [
          DefaultTheme.light,
          DefaultTheme.dark,
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (context) => MaterialApp(
              title: 'MendMate',
              // routes: Routes.get(context),
              home: CustomersListView(),
              
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.themeOf(context).data,
            ),
          ),
        ),
      // ),
    );
  }
}
