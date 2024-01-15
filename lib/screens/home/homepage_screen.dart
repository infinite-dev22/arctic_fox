import 'package:animate_do/animate_do.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/complaints/complaints_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/screens/property/add_property_screen.dart';
import 'package:smart_rent/screens/property/property_list_screen.dart';
import 'package:smart_rent/screens/tenant/add_tenant_screen.dart';
import 'package:smart_rent/screens/tenant/tenant_list_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/complaints_widget.dart';
import 'package:smart_rent/widgets/home_card_widget1.dart';
import 'package:smart_rent/widgets/home_card_widget2.dart';

class HomePage extends StatefulWidget {
  final UserController userController;
  final TenantController tenantController;

  const HomePage(
      {super.key, required this.userController, required this.tenantController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late SingleValueDropDownController _propertyModelCont;

  final TextEditingController floorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? floorName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _propertyModelCont = SingleValueDropDownController();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Get.back(canPop: false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),

                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),

              ],
            ),
      ) ?? false; //if showDialouge had returned null, then return false
    }

    final _key = GlobalKey<ExpandableFabState>();
    // final UserController userController = Get.put(
    //     UserController(),);
    final ComplaintsController complaintsController =
    Get.put(ComplaintsController());
    // final TenantController tenantController = Get.put(
    //   TenantController(),
    // );
    final UnitController unitController =
    Get.put(UnitController(), permanent: true);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(

        floatingActionButtonLocation: userStorage.read('roleId') == 4
            ? null
            : ExpandableFab.location,
        floatingActionButton: userStorage.read('roleId') == 4
            ? Container()
            : ExpandableFab(
          distance: 7.5.h,
          key: _key,
          type: ExpandableFabType.up,
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: Container(
              width: 14.w,
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: AppTheme.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Icon(Icons.add, color: Colors.white,),
                ),
              ),
            ),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
          ),
          closeButtonBuilder: RotateFloatingActionButtonBuilder(
            child: Container(
              width: 14.w,
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: AppTheme.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Icon(Icons.cancel, color: Colors.white,),
                ),
              ),
            ),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,

          ),
          children: [
            FloatingActionButton.extended(
              splashColor: Colors.transparent,
              elevation: 0.0,
              heroTag: null,
              label: Bounceable(
                onTap: () {
                  final state = _key.currentState;
                  if (state != null) {
                    debugPrint('isOpen:${state.isOpen}');
                    state.toggle();
                  }
                  Get.to(() => AddTenantScreen(),
                      transition: Transition.downToUp);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 3.w,),
                        Text('Add Tenant', style: AppTheme.subTextBold2)

                      ],
                    ),
                  ),
                ),
              ),

              onPressed: () {},
              backgroundColor: Colors.transparent,
            ),

            FloatingActionButton.extended(
              splashColor: Colors.transparent,
              elevation: 0.0,
              heroTag: null,
              label: Bounceable(
                onTap: () {
                  final state = _key.currentState;
                  if (state != null) {
                    debugPrint('isOpen:${state.isOpen}');
                    state.toggle();
                  }
                  Get.to(() => AddPropertyScreen(),
                      transition: Transition.downToUp);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.house),
                        SizedBox(width: 3.w,),
                        Text('Add Property', style: AppTheme.subTextBold2)

                      ],
                    ),
                  ),
                ),
              ),

              onPressed: () {},
              backgroundColor: Colors.transparent,
            ),

            FloatingActionButton.extended(
              splashColor: Colors.transparent,
              elevation: 0.0,
              heroTag: null,
              label: Bounceable(
                onTap: () {
                  final state = _key.currentState;
                  if (state != null) {
                    debugPrint('isOpen:${state.isOpen}');
                    state.toggle();
                  }
                  showDialog(

                      context: context,
                      builder: (BuildContext c) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)
                          ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 1.h,),
                                  Text('Attach Floor To Property',
                                    style: AppTheme.appTitle3,),

                                  SizedBox(height: 3.h,),

                                  Obx(() {
                                    return SizedBox(
                                      width: 90.w,
                                      child: SearchablePropertyModelListDropDown<
                                          PropertyModel>(
                                        hintText: 'Property',
                                        menuItems: widget.tenantController
                                            .propertyModelList.value,
                                        controller: _propertyModelCont,
                                        onChanged: (value) {
                                          widget.tenantController
                                              .setSelectedPropertyId(
                                              value.value.id);
                                        },
                                      ),
                                    );
                                  }),

                                  AuthTextField(
                                    controller: floorController,
                                    hintText: 'Floor No.',
                                    obscureText: false,
                                    onChanged: (value) {

                                      floorName = floorController.text.trim();
                                      print(floorName.toString());
                                    },
                                  ),

                                  SizedBox(height: 1.h,),

                                  AuthTextField(
                                    controller: descriptionController,
                                    hintText: 'Description',
                                    obscureText: false,
                                    onChanged: (value) {
                                      print('${descriptionController.text.trim()
                                          .toString()}');
                                    },
                                  ),

                                  SizedBox(height: 1.h,),

                                  SizedBox(
                                    width: 50.w,
                                    child: Obx(() {
                                      return AppButton(
                                        isLoading: unitController.isAddFloorLoading.value,
                                        title: 'Add Floor',
                                        color: AppTheme.primaryColor,
                                        function: () async {

                                          if(widget.tenantController.selectedPropertyId.value == 0){
                                            Fluttertoast.showToast(msg: 'select property');
                                          } else if (floorController.text.isEmpty){
                                            Fluttertoast.showToast(msg: 'floor name required');
                                          } else if (floorController.text.length <= 1){
                                            Fluttertoast.showToast(msg: 'floor name too short');
                                          } else {
                                            await unitController.addFloorToProperty(
                                              widget.tenantController.selectedPropertyId.value,
                                              floorController.text.trim().toString(),
                                              descriptionController.text.trim().toString(),
                                            ).then((value){
                                              widget.tenantController.setSelectedPropertyId(0);
                                              floorController.clear();
                                              descriptionController.clear();
                                              floorName == '';
                                            });
                                          }


                                          // widget.userController
                                          //     .addPropertyToEmployee(
                                          //     widget.tenantController
                                          //         .selectedPropertyId.value,
                                          //     widget.userProfileModel.roleId!,
                                          //     widget.userProfileModel.userId!
                                          // );
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
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.meeting_room),
                        SizedBox(width: 3.w,),
                        Text('Add Floor To Property',
                            style: AppTheme.subTextBold2)

                      ],
                    ),
                  ),
                ),
              ),

              onPressed: () {},
              backgroundColor: Colors.transparent,
            ),

          ],
        ),

        backgroundColor: AppTheme.whiteColor,
        appBar: AppHeader(
          title: 'Dashboard',
          leading: Container(),
          actions: [
            PopupMenuButton(
              icon: Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Image.asset('assets/home/sidely.png'),
              ),
              onSelected: (value) async {
                if (value == 1) {
                  await widget.userController.logoutUser();
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text('LogOut'),
                  )
                ];
              },
            ),

          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome',
                      style: AppTheme.appTitle5,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),

                    userStorage.read('userFirstname') == null ? ZoomIn(
                      child: SizedBox(
                        child: Obx(() {
                          return Text(
                            // userStorage.read('userFirstname').toString(),
                            '${widget.userController.userFirstname.value}'
                                .capitalizeFirst.toString(),
                            style: AppTheme.blueAppTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),

                        width: 47.5.w,
                      ), delay: Duration(seconds: 0),) :
                    ZoomIn(
                      child: SizedBox(
                        child: Text(
                          userStorage
                              .read('userFirstname')
                              .toString()
                              .capitalizeFirst
                              .toString(),
                          style: AppTheme.blueAppTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        width: 47.5.w,
                      ), delay: Duration(seconds: 0),)


                    // userStorage.read('userFirstname') == null ?
                    // ZoomIn(
                    //   child: SizedBox(
                    //     child: Obx(() {
                    //       return Text(
                    //         '${userController.userFirstname.value} ',
                    //         style: AppTheme.appTitle2,
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //       );
                    //     }),
                    //
                    //     width: 47.5.w,
                    //   ), delay: Duration(seconds: 0),)
                    //     : ZoomIn(
                    //   child: SizedBox(
                    //     child: Text(
                    //       // '${userController.userFirstname.value} ',
                    //       userStorage.read('userFirstname'),
                    //       style: AppTheme.appTitle2,
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //     width: 47.5.w,
                    //   ), delay: Duration(seconds: 0),),
                  ],
                ),
                // Text(userController.userFirstname.value),

                SizedBox(
                  height: 1.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return HomeCardWidget1(
                        color: AppTheme.greenCardColor,
                        total: widget.tenantController.propertyModelList.value
                            .length,
                        title: 'Total Property',
                        function: () {
                          Get.to(
                                  () =>
                                  PropertyListScreen(
                                    unitController: unitController,
                                    tenantController: widget.tenantController,
                                  ),
                              transition: Transition.zoom);
                        },
                      );
                    }),
                    Obx(() {
                      return HomeCardWidget1(
                        color: AppTheme.redCardColor,
                        total: widget.tenantController.tenantList.value.length,
                        title: 'Total Tenants',
                        function: () {
                          Get.to(
                                  () =>
                                  TenantListScreen(
                                    tenantController: widget.tenantController,
                                  ),
                              transition: Transition.zoom);
                        },
                      );
                    }),
                  ],
                ),

                SizedBox(
                  height: 2.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCardWidget2(
                      image: 'assets/home/wallet.png',
                      title: 'Payment Received',
                      number: 25001,
                      function: () {},
                      isAmount: true,
                    ),
                    HomeCardWidget2(
                      image: 'assets/home/eye.png',
                      title: 'Total Views',
                      number: 1500055,
                      function: () {},
                      isAmount: false,
                    ),
                  ],
                ),

                SizedBox(
                  height: 2.h,
                ),

                ComplaintsWidget(
                  complaintsController: complaintsController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
