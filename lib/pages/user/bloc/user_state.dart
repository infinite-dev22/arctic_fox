part of 'user_bloc.dart';

enum UserStatus { initial, success, loading, accessDenied, error, empty }

extension LoginStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;

  bool get isSuccess => this == UserStatus.success;

  bool get isLoading => this == UserStatus.loading;

  bool get isError => this == UserStatus.error;

  bool get isEmpty => this == UserStatus.empty;
}

@immutable
class UserState extends Equatable {
  final List<UserResponse>? users;
  final UserStatus? status;

  const UserState({this.users, this.status = UserStatus.initial});

  @override
  List<Object?> get props => [users, status];

  // Copy state.
  UserState copyWith({
    final List<UserResponse>? users,
    final UserStatus? status,
  }) {
    return UserState(users: users ?? this.users, status: status ?? this.status);
  }
}

class UserInitial extends UserState {}
