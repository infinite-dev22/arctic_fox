part of 'user_details_bloc.dart';

enum UserDetailsStatus { initial, loading, success, error, accessDenied, empty }

class UserDetailsState extends Equatable {
  final UserDetailsModel? user;
  final UserDetailsStatus status;
  final bool? isLoading;
  const UserDetailsState({
    this.user,
    this.status = UserDetailsStatus.initial,
    this.isLoading =  false
});

  @override
  List<Object?> get props => [user, status, isLoading];

  UserDetailsState copyWith({
    UserDetailsModel? user,
    UserDetailsStatus? status,
    bool? isLoading
  }) {
    return UserDetailsState(
      user: user,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,

    );
  }

}

class UserDetailsInitial extends UserDetailsState {
  @override
  List<Object> get props => [];
}

class UserDetailsLoading extends UserDetailsState {}
class UserDetailsSuccess extends UserDetailsState {}
class UserDetailsEmpty extends UserDetailsState {}
class UserDetailsAccessDenied extends UserDetailsState {}


