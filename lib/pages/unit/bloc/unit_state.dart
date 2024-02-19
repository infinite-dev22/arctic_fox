part of 'unit_bloc.dart';

enum UnitStatus { initial, success, loading, accessDenied, error, empty,
  loadingDetails, successDetails, errorDetails, emptyDetails
}

@immutable
class UnitState extends Equatable {
  final List<UnitModel>? units;
  final UnitStatus status;
  final UnitModel? unitModel;
  final bool? isLoading;
  const UnitState({
    this.units,
    this.status = UnitStatus.initial,
    this.unitModel,
    this.isLoading = false
});

  UnitState copyWith({
     List<UnitModel>? units,
     UnitStatus? status,
     UnitModel? unitModel,
     bool? isLoading,
}) {
    return UnitState(
      units: units ?? this.units,
      status: status ?? this.status,
      unitModel: unitModel ?? this.unitModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [units, status, unitModel, isLoading];
}

class UnitInitial extends UnitState {
  @override
  List<Object> get props => [];
}
