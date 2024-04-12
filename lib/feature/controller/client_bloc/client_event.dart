part of 'client_bloc.dart';

sealed class ClientEvent  {
  const ClientEvent();

}

class GetAllClient extends ClientEvent {}

class DeleteCleint extends ClientEvent {
  final Cleint model;

  const DeleteCleint({required this.model});
}
class UpdateCleint extends ClientEvent {
  final Cleint model;

  const UpdateCleint({required this.model});
}
class AddCleint extends ClientEvent {
  final Cleint model;

  const AddCleint({required this.model});
}
