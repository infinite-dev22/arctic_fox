part of 'property_bloc.dart';


enum PropertyStatus { initial, success, loading, accessDenied, error, empty,
  loadingDetails, successDetails, errorDetails, emptyDetails
}

@immutable
class PropertyState extends Equatable {
  final List<Property>? properties;
  final PropertyStatus? status;
  final Property? property;
  final bool? isPropertyLoading;
  const PropertyState({
    this.properties,
    this.status = PropertyStatus.initial,
    this.property,
    this.isPropertyLoading = false,
});

  @override
  // TODO: implement props
  List<Object?> get props => [properties, status, property, isPropertyLoading];

  PropertyState copyWith({
    List<Property>? properties,
    PropertyStatus? status,
    Property? property,
    bool? isPropertyLoading,
}) {
    return PropertyState(
      properties: properties ?? this.properties,
      status: status ?? this.status,
      property: property ?? this.property,
      isPropertyLoading: isPropertyLoading ?? this.isPropertyLoading,
    );
  }

}

class PropertyInitial extends PropertyState {
  @override
  List<Object> get props => [];
}
