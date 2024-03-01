import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/nation/nation_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/nation_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'nation_event.dart';
part 'nation_state.dart';

class NationBloc extends Bloc<NationEvent, NationState> {
  NationBloc() : super(NationState()) {
    on<LoadNationsEvent>(_mapFetchNationsToState);
  }

  _mapFetchNationsToState(
      LoadNationsEvent event, Emitter<NationState> emit) async {
    emit(state.copyWith(status: NationStatus.loading));
    await NationRepoImpl()
        .getALlNations(userStorage.read('accessToken').toString())
        .then((nations) {
      if (nations.isNotEmpty) {
        emit(state.copyWith(status: NationStatus.success, nations: nations));
      } else {
        emit(state.copyWith(status: NationStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: NationStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }
}
