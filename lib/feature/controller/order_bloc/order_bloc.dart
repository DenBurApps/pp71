import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:pp71/core/models/order.dart';
import 'package:pp71/feature/services/order_datasoruce.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderDataSource _dataSource = GetIt.instance<OrderDataSource>();
  OrderBloc() : super(InitialState()) {
    on<GetAllOrder>((event, emit) async {
      emit(LoadingState());
      final loadLessons = await _dataSource.getAllOrders();
      if (loadLessons.isNotEmpty) {
        emit(OrderLoaded(response: loadLessons));
      } else {
        emit(const ErrorState(message: 'Orders are empty'));
      }
    });
    on<DeleteOrder>((event, emit) async {
      emit(LoadingState());
      await _dataSource.deleteOrder(event.model.id!);
        final loadLessons = await _dataSource.getAllOrders();
      if (loadLessons.isNotEmpty) {
        emit(OrderLoaded(response: loadLessons));
      } else {
        // emit(const ErrorState());
      }
    });
    on<AddOrder>((event, emit) async {
      emit(LoadingState());
      await _dataSource.insertOrder(event.model);
        final loadLessons = await _dataSource.getAllOrders();
      if (loadLessons.isNotEmpty) {
        emit(OrderLoaded(response: loadLessons));
      } else {
        // emit(const ErrorState(message: 'Orders are empty'));
      }
    });
    on<UpdateOrder>((event, emit) async {
   
      emit(LoadingState());
      if (event.model.id != null) {
        await _dataSource.updateOrder(event.model);
          final loadLessons = await _dataSource.getAllOrders();
      if (loadLessons.isNotEmpty) {
        emit(OrderLoaded(response: loadLessons));
      } else {
        emit(const ErrorState(message: 'Orders are empty'));
      }
      } else {
        // emit(const ErrorState(message: 'try again later'));
      }
    });
  }
}
