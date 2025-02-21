import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/models/user/user_profile_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final UserController userController;
  final UserProfileModel userProfileModel;

  const EmployeeDetailsScreen({
    super.key,
    required this.userController,
    required this.userProfileModel,
  });

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  final TenantController mytenantController = Get.put(TenantController());
  late SingleValueDropDownController _propertyModelCont;
  late String role;

  final TenantController tenantController = Get.find<TenantController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // mytenantController.fetchAllPaymentSchedules(widget.tenantUnitId.toString());
    //
    // mytenantController.fetchAllPaymentSchedules(widget.tenantId!);
    // mytenantController.getSpecificTenantDetails(widget.tenantId!.toInt());

    role = widget.userProfileModel.roleId == 1
        ? 'Administrator'
        : widget.userProfileModel.roleId == 2
            ? 'Owner'
            : widget.userProfileModel.roleId == 3
                ? 'Manager'
                : 'Finance Manager';
    _propertyModelCont = SingleValueDropDownController();
    widget.userController.fetchAllEmployeePropertiesInOrganization(
        widget.userProfileModel.userId.toString());

    tenantController.listenToSpecificUserPropertyListChanges(
        widget.userProfileModel.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("After clicking the Android Back Button");
        widget.userController.employeePropertyModelList.clear();
        print(
            'My EMployee properties before == ${widget.userController.employeePropertyModelList}');
        return true;
      },
      child: Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: AppImageHeader(
          backFunction: () {
            print("After clicking the Android Back Button");
            widget.userController.employeePropertyModelList.clear();
            Get.back();
            print(
                'My EMployee properties before == ${widget.userController.employeePropertyModelList}');
          },
          title: 'assets/auth/srw.png',
          isTitleCentred: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/avatar/rian.jpg',
                            ),
                            radius: 7.5.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.userProfileModel.firstName} ${widget.userProfileModel.lastName}',
                                  style: AppTheme.appTitle3,
                                ),
                                Text(
                                  '${role}',
                                  style: AppTheme.subText,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Bounceable(
                      onTap: () async {
                        final Uri phoneUri = Uri(
                            scheme: 'tel',
                            path: widget.userProfileModel.phone.toString());
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          print('Cannot make Call');
                        }
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Image.asset('assets/general/call.png'),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Obx(() {
                    //   return Text(
                    //     widget.userController.employeePropertyModelList.value
                    //         .isEmpty
                    //         ? ' No Properties' : widget.userController
                    //         .employeePropertyModelList.value.length == 1
                    //         ? '1 Property'
                    //         : '${widget.userController.employeePropertyModelList
                    //         .length} Properties'
                    //     , style: AppTheme.appTitle3,);
                    // }),
                    Text(
                      'Properties',
                      style: AppTheme.appTitle3,
                    ),
                    Bounceable(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext c) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                child: Container(
                                  // height: 50.h,
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(15.sp),
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
                                          'Attach property',
                                          style: AppTheme.appTitle3,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Obx(() {
                                          return SizedBox(
                                            width: 65.w,
                                            child:
                                                SearchablePropertyModelListDropDown<
                                                    PropertyModel>(
                                              hintText: 'Property',
                                              menuItems: tenantController
                                                  .specificUserPropertyModelList
                                                  .value,
                                              controller: _propertyModelCont,
                                              onChanged: (value) {
                                                tenantController
                                                    .setSelectedPropertyId(
                                                        value.value.id);
                                              },
                                            ),
                                          );
                                        }),
                                        SizedBox(
                                          width: 50.w,
                                          child: Obx(() {
                                            return AppButton(
                                              isLoading: widget
                                                  .userController
                                                  .isAddPropertyToEmployeeLoading
                                                  .value,
                                              title:
                                                  'Add to ${widget.userProfileModel.firstName}',
                                              color: AppTheme.primaryColor,
                                              function: () async {
                                                widget.userController
                                                    .addPropertyToEmployee(
                                                        tenantController
                                                            .selectedPropertyId
                                                            .value,
                                                        widget.userProfileModel
                                                            .roleId!,
                                                        widget.userProfileModel
                                                            .userId!);
                                              },
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        width: 10.w,
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
                  ],
                ),

                SizedBox(
                  height: 1.h,
                ),

                Obx(() {
                  return widget.userController.isEmployeePropertyLoading.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Center(
                            child: Image.asset('assets/auth/logo.png',
                                width: 35.w),
                          ),
                        )
                      //     :
                      // widget.userController.employeePropertyModelList.value.isEmpty && widget.userController.isEmployeePropertyLoading.value == false
                      //     ? Container()
                      : widget.userController.employeePropertyModelList.value
                              .isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.userController
                                  .employeePropertyModelList.length,
                              itemBuilder: (context, index) {
                                var property = widget.userController
                                    .employeePropertyModelList[index];
                                // return Text(property.properties!.name.toString(),
                                //   style: AppTheme.blueSubText,);
                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.h),
                                    child: ListTile(
                                      title: Text(
                                        property.properties!.name.toString(),
                                        style: AppTheme.blueSubText,
                                      ),
                                      subtitle: Text(
                                        property.properties!.location
                                            .toString(),
                                        style: AppTheme.blackSubText,
                                      ),
                                      trailing: Text(
                                        property.properties!.squareMeters
                                                .toString() +
                                            ' ' +
                                            'sqm',
                                        style: AppTheme.subText,
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : Container(
                              // child: Padding(
                              //   padding: EdgeInsets.symmetric(vertical: 15.h),
                              //   child: Center(
                              //     child: Text('No Properties Attached', style: AppTheme.blueSubText),),
                              // ),
                              );
                })

                // Obx(() {
                //   var groupedData = widget.userController.groupAllPaymentSchedules();
                //   return widget.userController.isPaymentScheduleLoading.value ? Padding(
                //     padding: EdgeInsets.symmetric(vertical: 15.h),
                //     child: Center(
                //       child: Image.asset('assets/auth/logo.png', width: 35.w),),
                //   ) : widget.userController.propertyUnitScheduleList.value.isEmpty
                //       ? Center(child: Text('No Units Attached')) :  Wrap(
                //     alignment: WrapAlignment.center,
                //
                //     children: groupedData.keys.toList().map((unitId) => Bounceable(
                //       onTap: (){
                //         Get.to(() =>
                //             SpecificPaymentScheduleScreen(
                //               tenantController: widget.userController, unitId: int.parse(unitId),));
                //       },
                //       child: Card(
                //           color: AppTheme.primaryColor,
                //           child: Padding(
                //             padding:  EdgeInsets.all(17.5),
                //             child: Text(unitId.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.5.sp),),
                //           )),
                //     )).toList(),
                //   );
                //   //     : Expanded(
                //   //   child: ListView.builder(
                //   //     itemCount: groupedData.length,
                //   //       itemBuilder: (context, index) {
                //   //         var key = groupedData.keys.toList()[index];
                //   //         return Text('Unit $key');
                //   //       }),
                //   // );
                // }),

                // SizedBox(height: 2.h,),
                //
                // AppButton(
                //   title: 'View All Payment Schedules',
                //   color: Colors.black,
                //   function: () async {
                //     Get.to(() =>
                //         AllPaymentScheduleScreen(tenantController: widget.userController, tenantId: widget.tenantId!));
                //   },
                // ),
                //
                //
                // SizedBox(height: 2.h,),
                // AppButton(
                //   title: 'Contact',
                //   color: AppTheme.primaryColor,
                //   function: () async {
                //     final Uri phoneUri = Uri(
                //         scheme: 'tel',
                //         path: '0785556722'
                //     );
                //     if (await canLaunchUrl(phoneUri)) {
                //       await launchUrl(phoneUri);
                //     } else {
                //       print('Cannot make Call');
                //     }
                //   },
                // ),

                // GridView.builder(
                //   // padding: EdgeInsets.zero,
                //   shrinkWrap: true,
                //   itemCount: myRequirements.length,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //     itemBuilder: (context, index){
                //     var requirement = myRequirements[index];
                //     return TenantRequirementWidget(image: requirement.image, requirement: requirement.requirement);
                //     },
                // ),
                //
                // Wrap(
                //   direction: Axis.horizontal,
                //   spacing: 40.w,
                //   // spacing: 20.w,
                //   alignment: WrapAlignment.spaceBetween,
                //   children: [
                //
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
