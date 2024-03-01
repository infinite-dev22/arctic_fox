import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/employee/employee_list_response_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/employee_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeState()) {
    on<LoadEmployeesEvent>(_mapFetchEmployeesToState);
  }

  _mapFetchEmployeesToState(
      LoadEmployeesEvent event, Emitter<EmployeeState> emit) async {
    emit(state.copyWith(status: EmployeeStatus.loading));
    await EmployeeRepoImpl()
        .getALlEmployees(userStorage.read('accessToken').toString())
        .then((employees) {
      if (employees.isNotEmpty) {
        emit(state.copyWith(
            status: EmployeeStatus.success, employees: employees));
      } else {
        emit(state.copyWith(status: EmployeeStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: EmployeeStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(EmployeeEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<EmployeeEvent, EmployeeState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<EmployeeState> change) {
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
