import 'package:get_it/get_it.dart';
import 'package:pp71/feature/controller/client_bloc/client_bloc.dart';
import 'package:pp71/feature/controller/order_bloc/order_bloc.dart';
import 'package:pp71/feature/services/cleint_datasoruce.dart';
import 'package:pp71/feature/services/order_datasoruce.dart';



class ServiceLocator {
  static Future<void> setup() async {
    // GetIt.I.registerSingletonAsync<RemoteConfigService>(
    //     () => RemoteConfigService().init());
    // await GetIt.I.isReady<RemoteConfigService>();
    // GetIt.I
    //     .registerSingletonAsync<StorageService>(() => StorageService().init());
    // await GetIt.I.isReady<StorageService>();

    GetIt.I.registerLazySingleton<CleintDataSource>(() => CleintDataSource());

    GetIt.I.registerLazySingleton<CleintBloc>(() => CleintBloc());
    GetIt.I.registerLazySingleton<OrderDataSource>(() => OrderDataSource());

    GetIt.I.registerLazySingleton<OrderBloc>(() => OrderBloc());

  }
}
