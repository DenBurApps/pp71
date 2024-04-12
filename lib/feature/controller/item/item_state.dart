part of 'item_bloc.dart';

sealed class ItemState {
  const ItemState();
}

final class InitialState extends ItemState {}

final class ItemLoaded extends ItemState {
  final List<Item> response;
  const ItemLoaded({required this.response});
}

final class LoadingState extends ItemState {}

final class ErrorState extends ItemState {
  final String message;
  const ErrorState({required this.message});
}
