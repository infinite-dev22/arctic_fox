import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class FloorTabScreenLayout extends StatefulWidget {
  final int id;
  const FloorTabScreenLayout({super.key, required this.id});

  @override
  State<FloorTabScreenLayout> createState() => _FloorTabScreenLayoutState();
}

class _FloorTabScreenLayoutState extends State<FloorTabScreenLayout> {

  final TextEditingController searchController = TextEditingController();

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
                    // showAsBottomSheet(context);
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
}
