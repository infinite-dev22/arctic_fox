part of 'period_bloc.dart';

abstract class PeriodEvent extends Equatable {
  const PeriodEvent();
}

class LoadAllPeriodsEvent extends PeriodEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
