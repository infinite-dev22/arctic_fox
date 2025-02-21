import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_source/models/property/property_category_model.dart';
import 'package:smart_rent/data_source/repositories/implemantation/property_category_repo_impl.dart';
import 'package:smart_rent/utils/app_prefs.dart';

part 'property_category_event.dart';
part 'property_category_state.dart';

class PropertyCategoryBloc
    extends Bloc<PropertyCategoryEvent, PropertyCategoryState> {
  PropertyCategoryBloc() : super(PropertyCategoryInitial()) {
    on<LoadAllPropertyCategoriesEvent>(_mapFetchPropertyCategoriesToState);
  }

  _mapFetchPropertyCategoriesToState(LoadAllPropertyCategoriesEvent event,
      Emitter<PropertyCategoryState> emit) async {
    emit(state.copyWith(status: PropertyCategoryStatus.loading));
    await PropertyCategoryRepoImpl()
        .getALlPropertyCategories(userStorage.read('accessToken').toString())
        .then((categories) {
      if (categories.isNotEmpty) {
        emit(state.copyWith(
            status: PropertyCategoryStatus.success,
            propertyCategories: categories));
      } else {
        emit(state.copyWith(status: PropertyCategoryStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PropertyCategoryStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }
}
