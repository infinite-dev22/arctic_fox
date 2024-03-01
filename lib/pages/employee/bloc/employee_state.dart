part of 'employee_bloc.dart';

enum EmployeeStatus { initial, success, loading, accessDenied, error, empty }

@immutable
class EmployeeState extends Equatable {
  final List<EmployeeModel>? employees;
  final EmployeeStatus? status;

  const EmployeeState({this.employees, this.status = EmployeeStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [employees, status];

  EmployeeState copyWith({
    final List<EmployeeModel>? employees,
    final EmployeeStatus? status,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      status: status ?? this.status,
    );
  }
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object> get props => [];
}
