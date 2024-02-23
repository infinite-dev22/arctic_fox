import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/period/period_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/period_model_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  PeriodBloc() : super(PeriodState()) {
    on<LoadAllPeriodsEvent>(_mapFetchPeriodsToState);
  }

  _mapFetchPeriodsToState(LoadAllPeriodsEvent event, Emitter<PeriodState> emit) async{
    emit(state.copyWith(status: PeriodStatus.loading));
    await PeriodRepoImpl().getAllPeriods(userStorage.read('accessToken').toString()).then((periods) {
      if(periods.isNotEmpty){
        emit(state.copyWith(status: PeriodStatus.success, periods: periods));
      } else {
        emit(state.copyWith(status: PeriodStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PeriodStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

}
