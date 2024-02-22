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

class AddPropertyEvent extends PropertyEvent {
 final String token;
 final String name;
 final String location;
 final String sqm;
 final String description;
 final int propertyTypeId;
 final int propertyCategoryId;

  const AddPropertyEvent(this.token, this.name, this.location, this.sqm,
      this.description, this.propertyTypeId, this.propertyCategoryId);

  @override
  // TODO: implement props
  List<Object?> get props => [token, name, location, sqm, description, propertyTypeId, propertyCategoryId];

}