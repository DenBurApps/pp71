part of 'client_bloc.dart';

sealed class CleintState {
  const CleintState();
}

final class InitialState extends CleintState {}

final class CleintLoaded extends CleintState {
  final List<Cleint> response;
  const CleintLoaded({required this.response});
}

final class LoadingState extends CleintState {}

final class CleintErrorState extends CleintState {
  final String message;
  const CleintErrorState({required this.message});
}
