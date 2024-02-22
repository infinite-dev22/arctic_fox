part of 'unit_bloc.dart';

abstract class UnitEvent extends Equatable {
  const UnitEvent();
}

class LoadAllUnitsEvent extends UnitEvent {
  final int id;

  const LoadAllUnitsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}

class LoadUnitTypesEvent extends UnitEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
