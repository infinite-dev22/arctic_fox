part of 'unit_bloc.dart';

enum UnitStatus { initial, success, loading, accessDenied, error, empty,
  loadingDetails, successDetails, errorDetails, emptyDetails, successUT,
  loadingUT, accessDeniedUT, errorUT, emptyUT,
}

@immutable
class UnitState extends Equatable {
  final List<UnitModel>? units;
  final UnitStatus status;
  final UnitModel? unitModel;
  final bool? isLoading;
  final List<UnitTypeModel>? unitTypes;
  const UnitState({
    this.units,
    this.status = UnitStatus.initial,
    this.unitModel,
    this.isLoading = false,
    this.unitTypes
});

  UnitState copyWith({
     List<UnitModel>? units,
     UnitStatus? status,
     UnitModel? unitModel,
     bool? isLoading,
    List<UnitTypeModel>? unitTypes,
}) {
    return UnitState(
      units: units ?? this.units,
      status: status ?? this.status,
      unitModel: unitModel ?? this.unitModel,
      isLoading: isLoading ?? this.isLoading,
      unitTypes: unitTypes ?? this.unitTypes,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [units, status, unitModel, isLoading, unitTypes];
}

class UnitInitial extends UnitState {
  @override
  List<Object> get props => [];
}
