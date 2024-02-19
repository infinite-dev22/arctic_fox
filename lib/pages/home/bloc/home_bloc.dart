import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_rent/data_source/dtos/implemantation/logout_dto_impl.dart';
import 'package:smart_rent/data_source/repositories/implemantation/logout_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LogoutUserEvent>(_mapLogoutUserEventToState);
  }

  _mapLogoutUserEventToState(
      LogoutUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.initial, token: userStorage.read('accessToken')));
    await LogoutDtoImpl.logout(event.token).then((response)async {
      print('success ${response.success}');
      print('message ${response.message}');
      if (response.success == true && response.message!.isNotEmpty) {
        await userStorage.write('isLoggedIn', false).then((value) async {
         await userStorage.remove('accessToken').then((value) {
           emit(state.copyWith(status: HomeStatus.successLogout, message: response.message));
         });
        });

      }  else {
        emit(state.copyWith(status: HomeStatus.accessDenied,  message: response.message.toString()));
        // emit(state.copyWith(status: LoginStatus.accessDenied, isLoading: false));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: HomeStatus.error, message: error.toString()));
    });
  }

}
