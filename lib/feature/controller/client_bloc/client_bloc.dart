import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:pp71/core/models/cleint.dart';
import 'package:pp71/feature/services/cleint_datasoruce.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientDataSource _dataSource = GetIt.instance<ClientDataSource>();
  ClientBloc() : super(InitialState()) {
    on<GetAllClient>((event, emit) async {
      emit(LoadingState());
      final loadLessons = await _dataSource.getAllClient();
      if (loadLessons.isNotEmpty) {
        emit(ClientLoaded(response: loadLessons));
      } else {
        emit(const ClientErrorState(message: 'Client are empty'));
      }
    });
    on<DeleteClient>((event, emit) async {
      emit(LoadingState());
      await _dataSource.deleteHabits(event.model.id!);
       final loadLessons = await _dataSource.getAllClient();
      if (loadLessons.isNotEmpty) {
        emit(ClientLoaded(response: loadLessons));
      } else {
        emit(const ClientErrorState(message: 'Client are empty'));
      }
    });
    on<AddClient>((event, emit) async {
      emit(LoadingState());
      await _dataSource.insertClient(event.model);
       final loadLessons = await _dataSource.getAllClient();
      if (loadLessons.isNotEmpty) {
        emit(ClientLoaded(response: loadLessons));
      } else {
        emit(const ClientErrorState(message: 'Client are empty'));
      }
    });
    on<UpdateClient>((event, emit) async {
      emit(LoadingState());
      if (event.model.id != null) {
        await _dataSource.updateClient(event.model);
         final loadLessons = await _dataSource.getAllClient();
      if (loadLessons.isNotEmpty) {
        emit(ClientLoaded(response: loadLessons));
      } else {
        emit(const ClientErrorState(message: 'Client are empty'));
      }
      } else {
        // Обработка случая, когда id равен null
      }
    });
  }
}
