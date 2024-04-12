import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:pp71/core/models/cleint.dart';
import 'package:pp71/feature/services/cleint_datasoruce.dart';

part 'client_event.dart';
part 'client_state.dart';

class CleintBloc extends Bloc<ClientEvent, CleintState> {
  final CleintDataSource _dataSource = GetIt.instance<CleintDataSource>();
  CleintBloc() : super(InitialState()) {
    on<GetAllClient>((event, emit) async {
      emit(LoadingState());
      final loadLessons = await _dataSource.getAllCleint();
      if (loadLessons.isNotEmpty) {
        emit(CleintLoaded(response: loadLessons));
      } else {
        emit(const CleintErrorState(message: 'Cleint are empty'));
      }
    });
    on<DeleteCleint>((event, emit) async {
      emit(LoadingState());
      await _dataSource.deleteHabits(event.model.id!);
    });
    on<AddCleint>((event, emit) async {
      emit(LoadingState());
      await _dataSource.insertCleint(event.model);
    });
    on<UpdateCleint>((event, emit) async {
      emit(LoadingState());
      if (event.model.id != null) {
        await _dataSource.updateCleint(event.model);
      } else {
        // Обработка случая, когда id равен null
      }
    });
  }
}
