import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/data_source/models/property/property_response_model.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class FloorTabScreenLayout extends StatefulWidget {
  final int id;
  const FloorTabScreenLayout({super.key, required this.id});

  @override
  State<FloorTabScreenLayout> createState() => _FloorTabScreenLayoutState();
}

class _FloorTabScreenLayoutState extends State<FloorTabScreenLayout> {

  final TextEditingController searchController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController floorCodeController = TextEditingController();
  final TextEditingController floorDescriptionController = TextEditingController();
  final TextEditingController propertyDescriptionController =
  TextEditingController();

  String? floorName;
  late SingleValueDropDownController _propertyModelCont;
  int? selectedPropertyId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _propertyModelCont = SingleValueDropDownController();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 75.w,
                child: AuthTextField(
                  controller: searchController,
                  hintText: 'Search',
                  obscureText: false,
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Bounceable(
                  onTap: () {

                    _showAddFloorDialog(context);
                    // final TextEditingController floorController = TextEditingController();
                    // final TextEditingController floorCodeController = TextEditingController();
                    // final TextEditingController propertyDescriptionController =
                    // TextEditingController();

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppTheme.primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // SizedBox(
              //   width: 30.w,
              //   height: 6.5.h,
              //   child: AppButton(
              //       title: 'Add Tenant',
              //       color: AppTheme.primaryColor,
              //       function: () {
              //         showAsBottomSheet(context);
              //       }),
              // ),
            ],
          ),


          BlocBuilder<FloorBloc, FloorState>(
            builder: (context, state) {

              if (state.status == FloorStatus.initial) {
                context.read<FloorBloc>().add(LoadAllFloorsEvent(widget.id));
              }
              if (state.status == FloorStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } if (state.status == FloorStatus.success) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.floors!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var floor = state.floors![index];
                      return Card(
                        child: ListTile(
                          title: Text(floor.name.toString(), style: AppTheme.appTitle3),
                          subtitle: floor.description == null ? null : Text(floor.description.toString()),
                          trailing: Text(floor.code.toString(), style: AppTheme.blueSubText),
                        ),
                      );
                    });
              }
              if (state.status == FloorStatus.empty) {
                return const Center(
                  child: Text('No Floors'),
                );
              }
              if (state.status == FloorStatus.error) {
                return const Center(
                  child: Text('An error occurred'),
                );
              }
              return Container();

            },
          ),
        ],
      ),
    );
  }

  _showAddFloorDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<PropertyBloc>(create: (context) => PropertyBloc(),),
              BlocProvider<FloorBloc>(create: (context) => FloorBloc(),),

            ],
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.sp)),
              child: Container(
                // height: 50.h,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius:
                  BorderRadius.circular(15.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.w, vertical: 2.h),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Attach Floor To Property',
                        style: AppTheme.appTitle3,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      // SizedBox(
                      //   width: 90.w,
                      //   child: BlocBuilder<PropertyBloc,
                      //       PropertyState>(
                      //     // bloc: PropertyBloc(),
                      //     builder: (context, state) {
                      //       if (state.status ==
                      //           PropertyStatus.initial) {
                      //         context
                      //             .read<PropertyBloc>()
                      //             .add(
                      //             LoadPropertiesEvent());
                      //       }
                      //       if (state.status ==
                      //           PropertyStatus.empty) {
                      //         return Center(child: Text('No Tenants'),);
                      //       }  if (state.status ==
                      //           PropertyStatus.error) {
                      //         return Center(child: Text('An Error Occurred'),);
                      //       }
                      //       return SearchablePropertyModelListDropDown<
                      //           Property>(
                      //         hintText: 'Property',
                      //         menuItems: state.properties == null ? [] : state.properties! ,
                      //         controller:
                      //         _propertyModelCont,
                      //         onChanged: (value) {
                      //           setState(() {
                      //             selectedPropertyId = value.value.id;
                      //           });
                      //           print('Property is $selectedPropertyId}');
                      //         },
                      //       );
                      //
                      //
                      //
                      //     },
                      //   ),
                      // ),
                      AuthTextField(
                        controller: floorController,
                        hintText: 'Floor Name.',
                        obscureText: false,
                        onChanged: (value) {
                          floorName =
                              floorController.text.trim();
                          print(floorName.toString());
                        },
                      ),

                      SizedBox(
                        height: 1.h,
                      ),
                      DescriptionTextField(
                        controller:
                        propertyDescriptionController,
                        hintText: 'Description',
                        obscureText: false,
                        onChanged: (value) {
                          print(
                              '${propertyDescriptionController.text.trim().toString()}');
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: BlocListener<FloorBloc, FloorState>(
                          listener: (context, state) {
                            print(context.read<FloorBloc>().state.status);
                            if (state.status == FloorStatus.successAdd) {
                              Fluttertoast.showToast(msg: 'Floor Added Successfully', backgroundColor: Colors.green, gravity: ToastGravity.TOP);
                              Navigator.pop(context);
                            }
                            if (state.status == FloorStatus.accessDeniedAdd) {
                              Fluttertoast.showToast(
                                  msg: state.message.toString(),gravity: ToastGravity.TOP);
                            }if (state.status == FloorStatus.errorAdd) {
                              Fluttertoast.showToast(
                                  msg: state.message.toString(),gravity: ToastGravity.TOP);
                            }
                          },
                          child: BlocBuilder<FloorBloc, FloorState>(
                            builder: (context, state) {
                              return AppButton(
                                isLoading: context.read<FloorBloc>().state.isFloorLoading,
                                title: 'Add Floor',
                                color: AppTheme.primaryColor,
                                function: () async {

                                  if (selectedPropertyId == null) {
                                    Fluttertoast.showToast(
                                        msg:
                                        'select property',
                                        gravity:
                                        ToastGravity.TOP);
                                  } else if (floorController
                                      .text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg:
                                        'floor name required',
                                        gravity:
                                        ToastGravity.TOP);
                                  } else if (floorController
                                      .text.length <=
                                      1) {
                                    Fluttertoast.showToast(
                                        msg:
                                        'floor name too short',
                                        gravity:
                                        ToastGravity.TOP);
                                  } else {
                                    context.read<FloorBloc>().add(AddFloorEvent(
                                      userStorage.read('accessToken').toString(),
                                      widget.id,
                                      floorController.text.trim().toString(),
                                       floorDescriptionController.text.trim().toString(),
                                    ));
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

}
