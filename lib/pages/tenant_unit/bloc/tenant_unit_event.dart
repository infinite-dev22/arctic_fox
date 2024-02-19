part of 'tenant_unit_bloc.dart';

abstract class TenantUnitEvent extends Equatable {
  const TenantUnitEvent();
}

class LoadTenantUnitsEvent extends TenantUnitEvent {
  final int id;
  const LoadTenantUnitsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}