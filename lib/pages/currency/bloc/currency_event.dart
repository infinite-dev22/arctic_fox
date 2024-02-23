part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
}

class LoadAllCurrenciesEvent extends CurrencyEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}