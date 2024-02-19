import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/tenant/tenant_details_model.dart';
import 'package:smart_rent/data_source/models/tenant/tenant_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/tenant_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  TenantBloc() : super(TenantInitial()) {
    on<LoadAllTenantsEvent>(_mapFetchTenantsToState);
    on<LoadSingleTenantEvent>(_mapViewSingleTenantDetailsEventToState);
  }

  _mapFetchTenantsToState(LoadAllTenantsEvent event, Emitter<TenantState> emit) async{
    emit(state.copyWith(status: TenantStatus.loading));
    await TenantRepoImpl().getALlTenants(userStorage.read('accessToken').toString()).then((tenants) {
      if(tenants.isNotEmpty){
        emit(state.copyWith(status: TenantStatus.success, tenants: tenants));
      } else {
        emit(state.copyWith(status: TenantStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: TenantStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  _mapViewSingleTenantDetailsEventToState(LoadSingleTenantEvent event, Emitter<TenantState> emit) async {
    emit(state.copyWith(status: TenantStatus.loadingDetails,));
    await TenantRepoImpl().getSingleTenant(userStorage.read('accessToken').toString(), event.id).then((tenant) {
      if(tenant != null) {
        emit(state.copyWith(status: TenantStatus.successDetails, tenantModel: tenant));
      } else {
        emit(state.copyWith(status: TenantStatus.emptyDetails, tenantModel: null));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: TenantStatus.errorDetails, isLoading: false));
    });

  }

  @override
  void onEvent(TenantEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<TenantEvent, TenantState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<TenantState> change) {
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
