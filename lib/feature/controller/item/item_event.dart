part of 'item_bloc.dart';

sealed class ItemEvent  {
  const ItemEvent();

}

class GetAllItems extends ItemEvent {}

class DeleteItem extends ItemEvent {
  final Item model;

  const DeleteItem({required this.model});
}
class UpdateItem extends ItemEvent {
  final Item model;

  const UpdateItem({required this.model});
}
class AddItems extends ItemEvent {
  final Item model;

  const AddItems({required this.model});
}
