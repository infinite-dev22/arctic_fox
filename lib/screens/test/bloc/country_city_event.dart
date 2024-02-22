part of 'country_city_bloc.dart';

abstract class CountryCityEvent extends Equatable {
  const CountryCityEvent();
}

class LoadAllCountries extends CountryCityEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadSelectedCountry extends CountryCityEvent {
  final String selectedCountry;

  const LoadSelectedCountry(this.selectedCountry);

  @override
  // TODO: implement props
  List<Object?> get props => [selectedCountry];

}

class LoadAllRespectiveCities extends CountryCityEvent {
  final List<String> cities;

  const LoadAllRespectiveCities(this.cities);

  @override
  // TODO: implement props
  List<Object?> get props => [cities];

}
