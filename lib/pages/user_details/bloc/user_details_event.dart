part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();
}

class ViewUserDetailsEvent extends UserDetailsEvent {
  final int id;

  const ViewUserDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}
