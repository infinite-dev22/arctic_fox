part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LogoutUserEvent extends HomeEvent {
  final String token;

  const LogoutUserEvent(
    this.token,
  );

  @override
  List<Object> get props => [token];
}
