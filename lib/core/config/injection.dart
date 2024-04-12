import 'package:get_it/get_it.dart';



class ServiceLocator {
  static Future<void> setup() async {
    // GetIt.I.registerSingletonAsync<RemoteConfigService>(
    //     () => RemoteConfigService().init());
    // await GetIt.I.isReady<RemoteConfigService>();
    // GetIt.I
    //     .registerSingletonAsync<StorageService>(() => StorageService().init());
    // await GetIt.I.isReady<StorageService>();

    // GetIt.I.registerLazySingleton<ItemDataSource>(() => ItemDataSource());

    // GetIt.I.registerLazySingleton<ItemBloc>(() => ItemBloc());

  }
}
