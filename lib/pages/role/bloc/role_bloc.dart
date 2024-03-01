import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/role/role_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/role_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<LoadAllRoles>(_mapFetchRolesToState);
  }

  _mapFetchRolesToState(LoadAllRoles event, Emitter<RoleState> emit) async {
    emit(state.copyWith(status: RoleStatus.loading));
    await RoleRepoImpl()
        .getRoles(userStorage.read('accessToken').toString())
        .then((roles) {
      if (roles.isNotEmpty) {
        emit(state.copyWith(status: RoleStatus.success, roles: roles));
      } else {
        emit(state.copyWith(status: RoleStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: RoleStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }
}
