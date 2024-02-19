import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:smart_rent/data_source/dtos/implemantation/user_details_dto_impl.dart';
import 'package:smart_rent/data_source/models/user_details_response/user_details_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/user_details_repo.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<ViewUserDetailsEvent>(_mapViewUserDetailsEventToState);
  }

  _mapViewUserDetailsEventToState(ViewUserDetailsEvent event, Emitter<UserDetailsState> emit) async {
    emit(state.copyWith(status: UserDetailsStatus.loading,));
    await UserDetailsRepoImpl().getUserDetails(event.id).then((user) {
      if(user != null) {
        emit(state.copyWith(status: UserDetailsStatus.success, user: user));
      } else {
        emit(state.copyWith(status: UserDetailsStatus.empty, user: null));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: UserDetailsStatus.error, isLoading: false));
    });

  }

}
