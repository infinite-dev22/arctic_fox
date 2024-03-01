part of 'role_bloc.dart';

enum RoleStatus { initial, loading, success, error, accessDenied, empty }

@immutable
class RoleState extends Equatable {
  final List<RoleModel>? roles;
  final RoleStatus status;

  const RoleState({this.roles, this.status = RoleStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [roles, status];

  RoleState copyWith({
    final List<RoleModel>? roles,
    final RoleStatus? status,
  }) {
    return RoleState(
      roles: roles ?? this.roles,
      status: status ?? this.status,
    );
  }
}

class RoleInitial extends RoleState {
  @override
  List<Object> get props => [];
}
