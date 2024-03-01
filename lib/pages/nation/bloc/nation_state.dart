part of 'nation_bloc.dart';

enum NationStatus { initial, loading, success, accessDenied, empty, error }

@immutable
class NationState extends Equatable {
  final List<NationModel>? nations;
  final NationStatus? status;

  const NationState({this.nations, this.status = NationStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [nations, status];

  NationState copyWith({List<NationModel>? nations, NationStatus? status}) {
    return NationState(
      nations: nations ?? this.nations,
      status: status ?? this.status,
    );
  }
}

class NationInitial extends NationState {
  @override
  List<Object> get props => [];
}
