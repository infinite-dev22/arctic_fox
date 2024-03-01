part of 'home_bloc.dart';

enum HomeStatus { initial, successLogout, loading, accessDenied, error, logout }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;

  bool get isSuccess => this == HomeStatus.successLogout;

  bool get isLoading => this == HomeStatus.loading;

  bool get isError => this == HomeStatus.error;

  bool get isLogout => this == HomeStatus.logout;
}

class HomeState extends Equatable {
  final String? token;
  final String? message;
  final HomeStatus status;

  const HomeState(
      {this.token = '', this.message = '', this.status = HomeStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [token, message, status];

  HomeState copyWith({
    String? token,
    String? message,
    HomeStatus? status,
  }) {
    return HomeState(
        token: token ?? this.token,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class HomeLogout extends HomeState {}
