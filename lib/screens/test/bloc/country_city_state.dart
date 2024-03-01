part of 'country_city_bloc.dart';

enum CountryCityStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
  loadingDetails,
  successDetails,
  errorDetails,
  emptyDetails
}

@immutable
class CountryCityState extends Equatable {
  final List<String>? countries;
  final String? selectedCountry;
  final List<String>? cities;
  final CountryCityStatus status;

  const CountryCityState(
      {this.countries,
      this.selectedCountry,
      this.cities,
      this.status = CountryCityStatus.initial});

  CountryCityState copyWith({
    List<String>? countries,
    String? selectedCountry,
    List<String>? cities,
    CountryCityStatus? status,
  }) {
    return CountryCityState(
        countries: countries ?? this.countries,
        selectedCountry: selectedCountry ?? this.selectedCountry,
        cities: cities ?? this.cities,
        status: status ?? this.status);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [countries, selectedCountry, cities, status];
}

class CountryCityInitial extends CountryCityState {
  @override
  List<Object> get props => [];
}
