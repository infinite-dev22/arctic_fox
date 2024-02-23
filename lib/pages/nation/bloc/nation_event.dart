part of '../../../pages/nation/bloc/nation_bloc.dart';

abstract class NationEvent extends Equatable {
  const NationEvent();
}

class LoadNationsEvent extends NationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}