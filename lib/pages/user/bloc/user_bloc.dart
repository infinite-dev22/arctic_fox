import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/user_response/user_response.dart';
import 'package:smart_rent/data_source/repositories/implemantation/user_repo_impl.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<LoadUserEvent>(_mapFetchUsersToState);
  }

  _mapFetchUsersToState(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    await UserRepoImpl().getALl().then((users) {
      if (users.isNotEmpty) {
        emit(state.copyWith(status: UserStatus.success, users: users));
      } else {
        emit(state.copyWith(status: UserStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: UserStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(UserEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<UserEvent, UserState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<UserState> change) {
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
