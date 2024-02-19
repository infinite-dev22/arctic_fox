part of 'tenant_bloc.dart';

enum TenantStatus { initial, success, loading, accessDenied, error, empty,
  loadingDetails, successDetails, errorDetails, emptyDetails
}

@immutable
 class TenantState extends Equatable {
  final List<TenantModel>? tenants;
  final TenantStatus status;
  final TenantDetailsModel? tenantModel;
  final bool? isLoading;
  const TenantState({
    this.tenants,
    this.status = TenantStatus.initial,
    this.tenantModel,
    this.isLoading = false,
});

  TenantState copyWith({
     List<TenantModel>? tenants,
     TenantStatus? status,
    TenantDetailsModel? tenantModel,
     bool? isLoading,
}) {
    return TenantState(
      tenants: tenants ?? this.tenants,
      status: status ?? this.status,
      tenantModel: tenantModel ?? this.tenantModel,
      isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [tenants, status, tenantModel, isLoading];
}

class TenantInitial extends TenantState {
  @override
  List<Object> get props => [];
}
