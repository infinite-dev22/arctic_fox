part of 'property_bloc.dart';

abstract class PropertyEvent extends Equatable {
  const PropertyEvent();
}

class LoadPropertiesEvent extends  PropertyEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class LoadSinglePropertyEvent extends  PropertyEvent {
  final int id;

  const LoadSinglePropertyEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}