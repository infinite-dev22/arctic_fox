import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_rent/data_source/dtos/implemantation/forgot_password_dto_impl.dart';
import 'package:smart_rent/data_source/models/password/forgot_password_response_model.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<SendForgotPasswordEvent>(_mapSendForgotPasswordEventToState);
  }

  _mapSendForgotPasswordEventToState(
      SendForgotPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading, isLoading: true));
    await ForgotPasswordDtoImpl.sendForgotPasswordLink( event.email, userStorage.read('accessToken').toString()).then((response) {
      print('success ${response.msg}');

      if (response != null) {
        emit(state.copyWith(status: ForgotPasswordStatus.success, isLoading: false, forgotPasswordResponseModel: response, message: response.msg));
      } else {
        emit(state.copyWith(status: ForgotPasswordStatus.accessDenied, isLoading: false, message: response.msg));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: ForgotPasswordStatus.error, isLoading: false, message: error.toString()));
    });
  }

}
