import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/currency/currency_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/currency_model_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyState()) {
    on<LoadAllCurrenciesEvent>(_mapFetchCurrenciesToState);
  }

  _mapFetchCurrenciesToState(
      LoadAllCurrenciesEvent event, Emitter<CurrencyState> emit) async {
    emit(state.copyWith(status: CurrencyStatus.loading));
    await CurrencyRepoImpl()
        .getAllCurrencies(userStorage.read('accessToken').toString())
        .then((currencies) {
      if (currencies.isNotEmpty) {
        emit(state.copyWith(
            status: CurrencyStatus.success, currencies: currencies));
      } else {
        emit(state.copyWith(status: CurrencyStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: CurrencyStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }
}
