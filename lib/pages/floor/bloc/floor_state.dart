part of 'floor_bloc.dart';

enum FloorStatus { initial, success, loading, accessDenied, error, empty,
  loadingDetails, successDetails, errorDetails, emptyDetails
}

 class FloorState extends Equatable {
  final List<FloorModel>? floors;
  final FloorStatus status;
  final FloorModel? floorModel;
  final bool? isFloorLoading;

  const FloorState({
    this.floors,
    this.status = FloorStatus.initial,
    this.floorModel,
    this.isFloorLoading = false,
});

  FloorState copyWith({
    List<FloorModel>? floors,
    FloorStatus? status,
    FloorModel? floorModel,
    bool? isFloorLoading

}) {
    return FloorState(
      floors: floors ?? this.floors,
      status: status ?? this.status,
      floorModel: floorModel ?? this.floorModel,
      isFloorLoading: isFloorLoading ?? this.isFloorLoading
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [floors, status, floorModel, isFloorLoading];

}

@immutable
class FloorInitial extends FloorState {
  @override
  List<Object> get props => [];
}
