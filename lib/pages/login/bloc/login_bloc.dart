import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rent/data_source/dtos/implemantation/login_dto_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<AuthUserEvent>(_mapAuthUserEventToState);
  }

  _mapAuthUserEventToState(
      AuthUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading, isLoading: true));
    await LoginDtoImpl.post(event.email, event.password).then((response) {
      print('success ${response.success}');
      print('message ${response.message}');
      print('token ${response.token}');
      if (response.token != null && response.token!.isNotEmpty) {
        emit(state.copyWith(status: LoginStatus.success, isLoading: false));
        userStorage.write('isLoggedIn', true);
        userStorage.write('accessToken', response.token);
      } else if (response.success == false) {
        emit(state.copyWith(
            status: LoginStatus.accessDenied,
            isLoading: false,
            message: response.message.toString()));
      } else {
        // emit(state.copyWith(status: LoginStatus.accessDenied, isLoading: false));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: LoginStatus.error, isLoading: false));
    });
  }

  @override
  void onEvent(LoginEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<LoginState> change) {
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
