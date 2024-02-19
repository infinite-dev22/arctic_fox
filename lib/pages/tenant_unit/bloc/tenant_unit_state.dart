part of 'tenant_unit_bloc.dart';

enum TenantUnitStatus { initial, success, loading, accessDenied, error, empty,
  loadingDetails, successDetails, errorDetails, emptyDetails
}

@immutable
class TenantUnitState extends Equatable {
  final List<TenantUnitModel>? tenantUnits;
  final TenantUnitStatus status;
  final TenantUnitModel? tenantUnitModel;
  final bool? isLoading;
  const TenantUnitState({
    this.tenantUnits,
    this.status = TenantUnitStatus.initial,
    this.tenantUnitModel,
    this.isLoading =false
});

  TenantUnitState copyWith({
     List<TenantUnitModel>? tenantUnits,
     TenantUnitStatus? status,
    TenantUnitModel? tenantUnitModel,
     bool? isLoading,
}) {
    return TenantUnitState(
      tenantUnits: tenantUnits ?? this.tenantUnits,
      status: status ?? this.status,
      tenantUnitModel: tenantUnitModel ?? this.tenantUnitModel,
      isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [tenantUnits, status, tenantUnitModel, isLoading];
}

class TenantUnitInitial extends TenantUnitState {
  @override
  List<Object> get props => [];
}
