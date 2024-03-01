import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/screens/test/repos/impl/country_city_repo_impl.dart';

part 'country_city_event.dart';
part 'country_city_state.dart';

class CountryCityBloc extends Bloc<CountryCityEvent, CountryCityState> {
  CountryCityBloc() : super(CountryCityState()) {
    on<LoadAllCountries>(_onLoadCountries);
    on<LoadSelectedCountry>(_onLoadSelectedCountry);
  }

  _onLoadCountries(
      LoadAllCountries event, Emitter<CountryCityState> emit) async {
    emit(state.copyWith(status: CountryCityStatus.loading));
    await FakeCountryCityRepository().fetchCountries().then((countries) {
      if (countries.isNotEmpty) {
        emit(state.copyWith(
            status: CountryCityStatus.success, countries: countries));
        print('My countries = $countries');
      } else {
        emit(state.copyWith(status: CountryCityStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: CountryCityStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  _onLoadSelectedCountry(
      LoadSelectedCountry event, Emitter<CountryCityState> emit) async {
    emit(state.copyWith(
      status: CountryCityStatus.loading,
    ));
    await FakeCountryCityRepository()
        .fetchCities(event.selectedCountry)
        .then((cities) {
      if (cities.isNotEmpty) {
        emit(state.copyWith(status: CountryCityStatus.success, cities: cities));
      } else {
        emit(state.copyWith(status: CountryCityStatus.empty, cities: null));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        status: CountryCityStatus.error,
      ));
    });
  }

  @override
  void onEvent(CountryCityEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<CountryCityEvent, CountryCityState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<CountryCityState> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    print(stackTrace);
    super.onError(error, stackTrace);
  }
}
