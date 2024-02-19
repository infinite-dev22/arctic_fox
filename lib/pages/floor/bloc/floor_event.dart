part of 'floor_bloc.dart';

abstract class FloorEvent extends Equatable {
  const FloorEvent();
}

class LoadAllFloorsEvent extends FloorEvent {
  final int id;

  const LoadAllFloorsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}