import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:pp71/core/models/item.dart';
import 'package:pp71/feature/services/item_datasoruce.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemDataSource _dataSource = GetIt.instance<ItemDataSource>();
  ItemBloc() : super(InitialState()) {
    on<GetAllItems>((event, emit) async {
      emit(LoadingState());
      final loadLessons = await _dataSource.getItems();
      if (loadLessons.isNotEmpty) {
        emit(ItemLoaded(response: loadLessons));
      } else {
        emit(const ErrorState(message: 'Habits are empty, try again later'));
      }
    });
    on<DeleteItem>((event, emit) async {
      emit(LoadingState());
      await _dataSource.deleteItem(event.model.id!);
    });
    on<AddItems>((event, emit) async {
      emit(LoadingState());
      await _dataSource.addItem(event.model);
    });
    on<UpdateItem>((event, emit) async {
      emit(LoadingState());
      if (event.model.id != null) {
        await ItemDataSource().updateItem(event.model);
      } else {
        // Обработка случая, когда id равен null
      }
    });
  }
}
