import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/unit/unit_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/unit_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitState()) {
    on<LoadAllUnitsEvent>(_mapFetchUnitsToState);
  }

  _mapFetchUnitsToState(LoadAllUnitsEvent event, Emitter<UnitState> emit) async{
    emit(state.copyWith(status: UnitStatus.loading));
    await UnitRepoImpl().getALlUnits(userStorage.read('accessToken').toString(), event.id).then((units) {
      if(units.isNotEmpty){
        emit(state.copyWith(status: UnitStatus.success, units: units));
      } else {
        emit(state.copyWith(status: UnitStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: UnitStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  // _mapViewSingleFloorDetailsEventToState(LoadSinglePropertyEvent event, Emitter<PropertyState> emit) async {
  //   emit(state.copyWith(status: PropertyStatus.loadingDetails,));
  //   await PropertyRepoImpl().getSingleProperty(event.id, userStorage.read('accessToken').toString()).then((property) {
  //     if(property != null) {
  //       emit(state.copyWith(status: PropertyStatus.successDetails, property: property));
  //     } else {
  //       emit(state.copyWith(status: PropertyStatus.emptyDetails, property: null));
  //     }
  //   }).onError((error, stackTrace) {
  //     emit(state.copyWith(status: PropertyStatus.errorDetails, isPropertyLoading: false));
  //   });
  //
  // }

  @override
  void onEvent(UnitEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<UnitEvent, UnitState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<UnitState> change) {
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
