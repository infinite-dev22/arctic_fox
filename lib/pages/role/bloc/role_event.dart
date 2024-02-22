part of 'role_bloc.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();
}

class LoadAllRoles extends RoleEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}