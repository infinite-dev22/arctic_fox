import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/tenant_unit_repo_impl.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'tenant_unit_event.dart';
part 'tenant_unit_state.dart';

class TenantUnitBloc extends Bloc<TenantUnitEvent, TenantUnitState> {
  TenantUnitBloc() : super(TenantUnitState()) {
    on<LoadTenantUnitsEvent>(_mapFetchTenantUnitsToState);
  }

  _mapFetchTenantUnitsToState(LoadTenantUnitsEvent event, Emitter<TenantUnitState> emit) async{
    emit(state.copyWith(status: TenantUnitStatus.loading));
    await TenantUnitRepoImpl().getALlTenantUnits(userStorage.read('accessToken').toString(), event.id).then((tenantUnits) {
      if(tenantUnits.isNotEmpty){
        emit(state.copyWith(status: TenantUnitStatus.success, tenantUnits: tenantUnits));
      } else {
        emit(state.copyWith(status: TenantUnitStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: TenantUnitStatus.error));
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
  void onEvent(TenantUnitEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<TenantUnitEvent, TenantUnitState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<TenantUnitState> change) {
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
