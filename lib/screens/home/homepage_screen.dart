import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/complaints/complaints_controller.dart';
import 'package:smart_rent/controllers/property/property_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/property/property_category_model.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/models/property/property_type_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/screens/property/add_property_screen.dart';
import 'package:smart_rent/screens/property/property_list_screen.dart';
import 'package:smart_rent/screens/tenant/add_tenant_screen.dart';
import 'package:smart_rent/screens/tenant/tenant_list_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_loader.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/complaints_widget.dart';
import 'package:smart_rent/widgets/home_card_widget1.dart';
import 'package:smart_rent/widgets/home_card_widget2.dart';
import 'package:smart_rent/widgets/tenant_profile_contact_form.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class HomePage extends StatefulWidget {
  final UserController userController;
  final TenantController tenantController;

  const HomePage(
      {super.key, required this.userController, required this.tenantController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PropertyController propertyController = Get.put(PropertyController());

  late SingleValueDropDownController _propertyModelCont;

  final TextEditingController floorController = TextEditingController();
  final TextEditingController propertyDescriptionController = TextEditingController();
  String? floorName;

  final _propertyKey = GlobalKey<ExpandableFabState>();

  File? propertyPic;
  String? propertyImagePath;
  String? propertyImageExtension;
  String? propertyFileName;
  Uint8List? propertyBytes;

  final TextEditingController propertyTitleController = TextEditingController();
  final TextEditingController propertyAddressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController propertyLocationController = TextEditingController();
  final TextEditingController propertySqmController = TextEditingController();


  final _tenantKey = GlobalKey<ExpandableFabState>();

  File? tenantPic;
  String? tenantImagePath;
  String? tenantImageExtension;
  String? tenantFileName;
  Uint8List? tenantBytes;

  File? companyTenantPic;
  String? companyTenantImagePath;
  String? companyTenantImageExtension;
  String? companyTenantFileName;
  Uint8List? companyTenantBytes;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController surnameNameController = TextEditingController();
  final TextEditingController otherNameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyDescriptionController = TextEditingController();

  final TextEditingController individualFirstNameController =
  TextEditingController();
  final TextEditingController individualLastNameController =
  TextEditingController();
  final TextEditingController individualEmailNameController =
  TextEditingController();
  final TextEditingController individualPhoneNameController =
  TextEditingController();
  final TextEditingController individualDateOfBirthController =
  TextEditingController();
  final TextEditingController individualNinController = TextEditingController();
  final TextEditingController individualDescriptionController = TextEditingController();
  final TextEditingController individualGenderController =
  TextEditingController();

  final TextEditingController contactFirstNameController =
  TextEditingController();
  final TextEditingController contactLastNameController =
  TextEditingController();
  final TextEditingController contactNinController = TextEditingController();
  final TextEditingController contactDesignationController =
  TextEditingController();
  final TextEditingController contactPhoneController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();

  final Rx<DateTime> myDateOfBirth = Rx<DateTime>(DateTime.now());

  final _formKey = GlobalKey<FormState>();
  final _individualFormKey = GlobalKey<FormState>();
  final _contactFormKey = GlobalKey<FormState>();
  final _companyFormKey = GlobalKey<FormState>();

  final companyNameValidator = MultiValidator([
    RequiredValidator(errorText: 'business name required'),
    MinLengthValidator(3, errorText: 'business name short'),
    MaxLengthValidator(15, errorText: 'business name too long'),
  ]);

  final contactNinValidator = MultiValidator([
    RequiredValidator(errorText: 'NIN required'),
    MinLengthValidator(10, errorText: 'NIN too short'),
    MaxLengthValidator(12, errorText: 'NIN too long'),
  ]);

  final contactEmailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'input does\'nt match email'),
  ]);


  final contactFirstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'first name required'),
    MinLengthValidator(2, errorText: 'first name too short'),
    MaxLengthValidator(15, errorText: 'first name too long'),
  ]);

  final contactLastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'last name required'),
    MinLengthValidator(2, errorText: 'last name too short'),
    MaxLengthValidator(15, errorText: 'last name too long'),
  ]);

  final contactPhoneValidator = MultiValidator([
    RequiredValidator(errorText: 'contact required'),
    MinLengthValidator(10, errorText: 'contact short'),
    MaxLengthValidator(15, errorText: 'contact too long'),
  ]);

  final contactDesignationValidator = MultiValidator([
    RequiredValidator(errorText: 'designation required'),
    MinLengthValidator(2, errorText: 'designation too short'),
    MaxLengthValidator(15, errorText: 'designation too long'),
  ]);

  Future<void> _selectDateOfBirth(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: myDateOfBirth.value,
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    // );

    final DateTime? picked = await showDatePickerDialog(
      context: context,
      initialDate: myDateOfBirth.value,
      minDate: DateTime(2000),
      maxDate: DateTime.now(),
    );

    if (picked != null) {
      myDateOfBirth(picked);
      individualDateOfBirthController.text =
      '${DateFormat('MM/dd/yyyy').format(myDateOfBirth.value)}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _propertyModelCont = SingleValueDropDownController();
    propertyController.fetchAllPropertyTypes();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    surnameNameController.dispose();
    otherNameController.dispose();
    phoneNoController.dispose();

    contactEmailController.dispose();
    contactPhoneController.dispose();
    contactNinController.dispose();
    contactDesignationController.dispose();
    contactLastNameController.dispose();
    contactFirstNameController.dispose();
  }

  String generateCustomRandomId() {
    int randomPart = Random().nextInt(10000);

    String uniqueId = "T-${randomPart.toString()}";

    return uniqueId;
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
                  showAddPTenantBottomSheet(context);
                  // Get.to(() => AddTenantScreen(),
                  //     transition: Transition.downToUp);
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
                  showAddPropertyBottomSheet(context);
                  // Get.to(() => AddPropertyScreen(),
                  //     transition: Transition.downToUp);
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
                                    controller: propertyDescriptionController,
                                    hintText: 'Description',
                                    obscureText: false,
                                    onChanged: (value) {
                                      print(
                                          '${propertyDescriptionController.text
                                              .trim()
                                              .toString()}');
                                    },
                                  ),

                                  SizedBox(height: 1.h,),

                                  SizedBox(
                                    width: 50.w,
                                    child: Obx(() {
                                      return AppButton(
                                        isLoading: unitController
                                            .isAddFloorLoading.value,
                                        title: 'Add Floor',
                                        color: AppTheme.primaryColor,
                                        function: () async {
                                          if (widget.tenantController
                                              .selectedPropertyId.value == 0) {
                                            Fluttertoast.showToast(
                                                msg: 'select property');
                                          } else
                                          if (floorController.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: 'floor name required');
                                          } else
                                          if (floorController.text.length <=
                                              1) {
                                            Fluttertoast.showToast(
                                                msg: 'floor name too short');
                                          } else {
                                            await unitController
                                                .addFloorToProperty(
                                              widget.tenantController
                                                  .selectedPropertyId.value,
                                              floorController.text.trim()
                                                  .toString(),
                                              propertyDescriptionController.text
                                                  .trim().toString(),
                                            ).then((value) {
                                              widget.tenantController
                                                  .setSelectedPropertyId(0);
                                              floorController.clear();
                                              propertyDescriptionController
                                                  .clear();
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

  void showAddPropertyBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(
        context,
        builder: (context) {
          return SlidingSheetDialog(
            extendBody: false,
            maxWidth: 90.h,
            duration: Duration(microseconds: 1),
            minHeight: 90.h,
            elevation: 8,
            cornerRadius: 15.sp,
            snapSpec: const SnapSpec(
              snap: false,
              snappings: [ 0.9],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return WillPopScope(
                      onWillPop: () async {
                        propertyTitleController.clear();
                        propertyAddressController.clear();
                        propertyDescriptionController.clear();
                        propertyLocationController.clear();
                        propertySqmController.clear();
                        propertyPic = File('');
                        print('Pic = ${propertyPic!.path}');
                        return true;
                      },
                      child: Material(
                        color: AppTheme.whiteColor,
                        child: Column(
                          children: [

                            Material(
                              elevation: 1,
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 7.5.h,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                    ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 2.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Bounceable(
                                          onTap: () {
                                            propertyTitleController.clear();
                                            propertyAddressController.clear();
                                            propertyDescriptionController
                                                .clear();
                                            propertyLocationController.clear();
                                            propertySqmController.clear();
                                            propertyPic = File('');
                                            print('Pic = ${propertyPic!.path}');

                                            Get.back();
                                          },
                                          child: Text(
                                            'Cancel', style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17.5.sp,
                                          ),)),

                                      Text('Add Property', style: AppTheme
                                          .darkBlueTitle2,),

                                      Obx(() {
                                        return propertyController.isAddPropertyLoading.value ?
                                        AppLoader(color: AppTheme.primaryColor,) :
                                        Bounceable(
                                            onTap: () async {

                                              if(
                                              propertyTitleController.text.isEmpty ||
                                                  propertyLocationController.text.isEmpty ||
                                              propertySqmController.text.isEmpty ||
                                              propertyPic == null ||
                                                  propertyController.propertyTypeId.value == 0 ||
                                                  propertyController.categoryId.value == 0
                                              ) {
                                                Fluttertoast.showToast(msg: 'fill in all fields', gravity: ToastGravity.TOP);

                                              } else {

                                                propertyController.addProperty(
                                                    propertyTitleController.text
                                                        .trim().toString(),
                                                    propertyDescriptionController
                                                        .text.trim().toString(),
                                                    userStorage.read(
                                                        'OrganizationId'),
                                                    propertyController
                                                        .propertyTypeId.value,
                                                    propertyController.categoryId
                                                        .value,
                                                    propertyLocationController
                                                        .text.trim().toString(),
                                                    propertySqmController.text
                                                        .trim().toString(),
                                                    userStorage.read(
                                                        'userProfileId')
                                                        .toString(),
                                                    userStorage.read(
                                                        'userProfileId')
                                                        .toString(),
                                                    propertyBytes!,
                                                    propertyImageExtension!,
                                                    propertyFileName!
                                                  // "userStorage.read('userProfileId')",
                                                );

                                              }


                                            },
                                            child: Text('Add', style: TextStyle(
                                              color: AppTheme.primaryColor,
                                              fontSize: 17.5.sp,
                                            ),));
                                      }),

                                    ],

                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w,
                                  vertical: 1.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AuthTextField(
                                      controller: propertyTitleController,
                                      hintText: 'Property title',
                                      obscureText: false,
                                    ),

                                    SizedBox(height: 1.h,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [

                                        SizedBox(
                                          width: 42.5.w,
                                          child: Obx(() {
                                            return CustomApiGenericDropdown<
                                                PropertyTypeModel>(
                                              hintText: 'Type',
                                              menuItems: propertyController
                                                  .propertyTypeList.value,
                                              onChanged: (value) {
                                                print(value);
                                                propertyController
                                                    .setPropertyTypeId(
                                                    value!.id);
                                              },
                                            );
                                          }),
                                        ),

                                        SizedBox(
                                          width: 42.5.w,
                                          child: Obx(() {
                                            return CustomApiGenericDropdown<
                                                PropertyCategoryModel>(
                                              hintText: 'Category',
                                              menuItems: propertyController
                                                  .propertyCategoryList.value,
                                              onChanged: (value) {
                                                print(value!.id);
                                                propertyController
                                                    .setCategoryId(value.id);
                                              },
                                            );
                                          }),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 1.h,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 42.5.w,
                                          child: AuthTextField(
                                            controller: propertyLocationController,
                                            hintText: 'Location',
                                            obscureText: false,
                                          ),
                                        ),

                                        SizedBox(
                                          width: 42.5.w,
                                          child: AuthTextField(
                                            controller: propertySqmController,
                                            hintText: 'sqm',
                                            obscureText: false,
                                          ),
                                        ),


                                      ],
                                    ),

                                    SizedBox(height: 1.h,),

                                    AppMaxTextField(
                                      controller: propertyDescriptionController,
                                      hintText: 'Description',
                                      obscureText: false,
                                      fillColor: AppTheme.appBgColor,
                                    ),


                                    SizedBox(height: 1.h,),

                                    Bounceable(
                                      onTap: () {
                                        FullPicker(
                                          prefixName: 'select property',
                                          context: context,
                                          image: true,
                                          imageCamera: kDebugMode,
                                          imageCropper: true,
                                          onError: (int value) {
                                            print(" ----  onError ----=$value");
                                          },
                                          onSelected: (value) async {
                                            print(" ----  onSelected ----");

                                            setState(() {
                                              propertyPic = value.file.first;
                                              propertyImagePath =
                                                  value.file.first!.path;
                                              propertyImageExtension =
                                                  value.file.first!
                                                      .path
                                                      .split('.')
                                                      .last;
                                              propertyFileName =
                                                  value.file.first!
                                                      .path
                                                      .split('/')
                                                      .last;
                                            });
                                            propertyBytes =
                                            await propertyPic!.readAsBytes();
                                            print('MY PIC == $propertyPic');
                                            print(
                                                'MY path == $propertyImagePath');
                                            print('MY bytes == $propertyBytes');
                                            print(
                                                'MY extension == $propertyImageExtension');
                                            print(
                                                'MY FILE NAME == $propertyFileName');
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 50.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            color: AppTheme.appBgColor,
                                            borderRadius: BorderRadius.circular(
                                                15.sp),
                                            image: DecorationImage(
                                                image: FileImage(
                                                    propertyPic ?? File('')),
                                                fit: BoxFit.cover)
                                        ),
                                        child: propertyPic == null ||
                                            propertyPic!.path.isEmpty
                                            ? Center(
                                          child: Text('Upload profile pic'),)
                                            : null,
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        }
    );

    print(result); // This is the result.
  }


  void showAddPTenantBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(
        context,
        builder: (context) {
          return SlidingSheetDialog(
            extendBody: false,
            maxWidth: 90.h,
            duration: Duration(microseconds: 1),
            minHeight: 90.h,
            elevation: 8,
            cornerRadius: 15.sp,
            snapSpec: const SnapSpec(
              snap: false,
              snappings: [ 0.9],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return WillPopScope(
                      onWillPop: () async {
                        firstNameController.clear();
                        surnameNameController.clear();
                        otherNameController.clear();
                        phoneNoController.clear();
                        companyNameController.clear();
                        companyDescriptionController.clear();
                        individualFirstNameController.clear();
                        individualLastNameController.clear();
                        individualEmailNameController.clear();
                        individualPhoneNameController.clear();
                        individualDateOfBirthController.clear();
                        individualNinController.clear();
                        individualDescriptionController.clear();
                        individualGenderController.clear();
                        contactFirstNameController.clear();
                        contactLastNameController.clear();
                        contactNinController.clear();
                        contactDesignationController.clear();
                        contactPhoneController.clear();
                        contactEmailController.clear();
                        tenantPic = File('');
                        companyTenantPic = File('');

                        return true;
                      },
                      child: Material(
                        color: AppTheme.whiteColor,
                        child: Column(
                          children: [

                            Material(
                              elevation: 1,
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 7.5.h,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                    ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 2.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Bounceable(
                                          onTap: () {
                                            firstNameController.clear();
                                            surnameNameController.clear();
                                            otherNameController.clear();
                                            phoneNoController.clear();
                                            companyNameController.clear();
                                            companyDescriptionController
                                                .clear();
                                            individualFirstNameController
                                                .clear();
                                            individualLastNameController
                                                .clear();
                                            individualEmailNameController
                                                .clear();
                                            individualPhoneNameController
                                                .clear();
                                            individualDateOfBirthController
                                                .clear();
                                            individualNinController.clear();
                                            individualDescriptionController
                                                .clear();
                                            individualGenderController.clear();
                                            contactFirstNameController.clear();
                                            contactLastNameController.clear();
                                            contactNinController.clear();
                                            contactDesignationController
                                                .clear();
                                            contactPhoneController.clear();
                                            contactEmailController.clear();
                                            tenantPic = File('');
                                            companyTenantPic = File('');
                                            Get.back();
                                          },
                                          child: Text(
                                            'Cancel', style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17.5.sp,
                                          ),)),

                                      Text('Add Tenant', style: AppTheme
                                          .darkBlueTitle2,),

                                      Bounceable(
                                          onTap: () async {
                                            if (widget.tenantController
                                                .tenantTypeId.value == 0) {
                                              Fluttertoast.showToast(
                                                  msg: 'Select Tenant Type');
                                            } else {
                                              if (widget.tenantController
                                                  .tenantTypeId.value == 1) {
                                                if (_formKey.currentState!
                                                    .validate() &&
                                                    _individualFormKey
                                                        .currentState!
                                                        .validate()) {
                                                  // Get.snackbar(
                                                  //     'Posting Individual', 'Adding Individual Tenant');

                                                  await widget.tenantController
                                                      .addPersonalTenant(
                                                      "${firstNameController
                                                          .text
                                                          .trim()} ${surnameNameController
                                                          .text.trim()}",
                                                      userStorage.read(
                                                          'OrganizationId'),
                                                      widget.tenantController
                                                          .tenantTypeId.value,
                                                      widget.tenantController
                                                          .businessTypeId.value,
                                                      userStorage.read(
                                                          'userProfileId'),
                                                      widget.tenantController
                                                          .nationalityId.value,
                                                      individualNinController
                                                          .text.toString(),
                                                      individualPhoneNameController
                                                          .text.toString(),
                                                      individualEmailNameController
                                                          .text.toString(),
                                                      individualDescriptionController
                                                          .text.toString(),
                                                      myDateOfBirth.value
                                                          .toString(),
                                                      widget.tenantController
                                                          .newGender.value,
                                                      tenantBytes!,
                                                      tenantImageExtension!,
                                                      tenantFileName!
                                                  );

                                                  Get.back();

                                                  // tenantController.addIndividualTenant(
                                                  //   "${firstNameController.text
                                                  //       .trim()} ${surnameNameController.text.trim()}",
                                                  //   12,
                                                  //   tenantController.tenantTypeId.value,
                                                  //   "userStorage.read('userProfileId')",
                                                  //   tenantController.nationalityId.value,
                                                  // );
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: 'Fill required fields');
                                                }
                                              } else {
                                                if (widget.tenantController
                                                    .isAddContactPerson
                                                    .isFalse) {
                                                  if (_formKey.currentState!
                                                      .validate() &&
                                                      _companyFormKey
                                                          .currentState!
                                                          .validate()) {
                                                    // Get.snackbar(
                                                    //     'Posting Company', 'No Company Contact');
                                                    await widget
                                                        .tenantController
                                                        .addCompanyTenantWithoutContact(
                                                        companyNameController
                                                            .text.toString(),
                                                        userStorage.read(
                                                            'OrganizationId'),
                                                        widget.tenantController
                                                            .tenantTypeId.value,
                                                        widget.tenantController
                                                            .businessTypeId
                                                            .value,
                                                        userStorage.read(
                                                            'userProfileId'),
                                                        widget.tenantController
                                                            .nationalityId
                                                            .value,
                                                        companyDescriptionController
                                                            .text.toString(),
                                                        companyTenantBytes!,
                                                        companyTenantImageExtension!,
                                                        companyTenantFileName!
                                                    );

                                                    Get.back();
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: 'Fill in fields');
                                                  }
                                                } else {
                                                  if (_formKey.currentState!
                                                      .validate() &&
                                                      _companyFormKey
                                                          .currentState!
                                                          .validate() &&
                                                      _contactFormKey
                                                          .currentState!
                                                          .validate()) {
                                                    // Get.snackbar(
                                                    //     'Posting Company', 'With Company Contact');
                                                    await widget
                                                        .tenantController
                                                        .addCompanyTenantWithContact(
                                                        companyNameController
                                                            .text.toString(),
                                                        userStorage.read(
                                                            'OrganizationId'),
                                                        widget.tenantController
                                                            .tenantTypeId.value,
                                                        widget.tenantController
                                                            .businessTypeId
                                                            .value,
                                                        userStorage.read(
                                                            'userProfileId'),
                                                        widget.tenantController
                                                            .nationalityId
                                                            .value,
                                                        contactFirstNameController
                                                            .text.trim()
                                                            .toString(),
                                                        contactLastNameController
                                                            .text.trim()
                                                            .toString(),
                                                        contactNinController
                                                            .text.trim()
                                                            .toString(),
                                                        contactDesignationController
                                                            .text.trim()
                                                            .toString(),
                                                        contactPhoneController
                                                            .text.trim()
                                                            .toString(),
                                                        contactEmailController
                                                            .text.trim()
                                                            .toString(),
                                                        companyDescriptionController
                                                            .text.toString(),
                                                        companyTenantBytes!,
                                                        companyTenantImageExtension!,
                                                        companyTenantFileName!
                                                    );

                                                    Get.back();
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: 'Fill in fields');
                                                  }
                                                }
                                              }
                                            }
                                          },
                                          child: Text('Add', style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 17.5.sp,
                                          ),)),

                                    ],
                                  ),
                                ),
                              ),),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w,
                                  vertical: 1.h),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Obx(() {
                                        return CustomApiTenantTypeDropdown(
                                          hintText: 'Select Tenant Type',
                                          menuItems: widget.tenantController
                                              .tenantTypeList.value,
                                          onChanged: (value) {
                                            widget.tenantController
                                                .setTenantTypeId(value!.id!);
                                          },
                                        );
                                      }),


                                      Obx(() {
                                        return widget.tenantController
                                            .tenantTypeId.value == 0
                                            ? Container()
                                            : CustomApiGenericDropdown<
                                            BusinessTypeModel>(
                                          hintText: "Business Type",
                                          menuItems: widget.tenantController
                                              .businessList.value,
                                          onChanged: (value) {
                                            widget.tenantController
                                                .setBusinessTypeId(value!.id!);
                                            print('MY Business == ${widget
                                                .tenantController
                                                .businessTypeId.value}');
                                          },
                                        );
                                      }),

                                      SizedBox(height: 1.h,),

                                      Obx(() {
                                        return widget.tenantController
                                            .tenantTypeId.value == 0
                                            ? Container()
                                            : CustomApiNationalityDropdown(
                                          hintText: 'Country',
                                          menuItems: widget.tenantController
                                              .nationalityList.value,
                                          onChanged: (value) {
                                            widget.tenantController
                                                .setNationalityId(value!.id!);
                                          },
                                        );
                                      }),

                                      Obx(() {
                                        return widget.tenantController
                                            .tenantTypeId.value == 1
                                            ? SlideInUp(
                                          child: Container(
                                            child: Form(
                                              key: _individualFormKey,
                                              child: Column(
                                                children: [
                                                  Text('Personal Details',
                                                    style: AppTheme.appTitle3,),
                                                  Obx(() {
                                                    return CustomApiGenericDropdown<
                                                        SalutationModel>(
                                                      hintText: 'Mr',
                                                      menuItems:
                                                      widget.tenantController
                                                          .salutationList.value,
                                                      onChanged: (value) {},
                                                      height: 6.5.h,
                                                    );
                                                  }),

                                                  SizedBox(height: 1.h,),

                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 42.5.w,
                                                        child: AuthTextField(
                                                          controller: firstNameController,
                                                          hintText: 'First Name',
                                                          obscureText: false,
                                                          keyBoardType: TextInputType
                                                              .text,
                                                          // validator: iFirstNameValidator,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 42.5.w,
                                                        child: AuthTextField(
                                                          controller: surnameNameController,
                                                          hintText: 'Surname',
                                                          obscureText: false,
                                                          keyBoardType: TextInputType
                                                              .text,
                                                          // validator: iLastNameValidator,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(height: 1.h,),

                                                  AuthTextField(
                                                    controller: individualEmailNameController,
                                                    hintText: 'Email',
                                                    obscureText: false,
                                                    keyBoardType: TextInputType
                                                        .emailAddress,
                                                    // validator: iEmailValidator,
                                                  ),

                                                  SizedBox(height: 1.h,),

                                                  AuthTextField(
                                                    controller: individualPhoneNameController,
                                                    hintText: 'Contact',
                                                    obscureText: false,
                                                    keyBoardType: TextInputType
                                                        .number,
                                                    // validator: iPhoneValidator,
                                                  ),

                                                  SizedBox(height: 1.h,),

                                                  AuthTextField(
                                                    controller: individualDateOfBirthController,
                                                    hintText: 'D.O.B',
                                                    obscureText: false,
                                                    onTap: () {
                                                      _selectDateOfBirth(
                                                          context);
                                                    },
                                                  ),

                                                  SizedBox(height: 1.h,),

                                                  AuthTextField(
                                                    controller: individualNinController,
                                                    hintText: 'NIN',
                                                    obscureText: false,
                                                    keyBoardType: TextInputType
                                                        .text,
                                                    // validator: iNinValidator,
                                                  ),

                                                  SizedBox(height: 1.h,),

                                                  Obx(() {
                                                    return CustomGenericDropdown<
                                                        String>(
                                                      hintText: 'Gender',
                                                      menuItems: widget
                                                          .tenantController
                                                          .genderList.value,
                                                      onChanged: (value) {
                                                        widget.tenantController
                                                            .setNewGender(
                                                            value.toString());
                                                      },

                                                    );
                                                  }),

                                                  SizedBox(height: 1.h,),

                                                  AuthTextField(
                                                    controller: individualDescriptionController,
                                                    hintText: 'Description',
                                                    obscureText: false,
                                                  ),

                                                  SizedBox(height: 1.h,),

                                                  Bounceable(
                                                    onTap: () {
                                                      FullPicker(
                                                        context: context,
                                                        file: true,
                                                        image: true,
                                                        video: true,
                                                        videoCamera: true,
                                                        imageCamera: true,
                                                        voiceRecorder: true,
                                                        videoCompressor: false,
                                                        imageCropper: false,
                                                        multiFile: true,
                                                        url: true,
                                                        onError: (int value) {
                                                          print(
                                                              " ----  onError ----=$value");
                                                        },
                                                        onSelected: (
                                                            value) async {
                                                          print(
                                                              " ----  onSelected ----");

                                                          setState(() {
                                                            tenantPic =
                                                                value.file
                                                                    .first;
                                                            tenantImagePath =
                                                                value.file
                                                                    .first!
                                                                    .path;
                                                            tenantImageExtension =
                                                                value.file
                                                                    .first!
                                                                    .path
                                                                    .split('.')
                                                                    .last;
                                                            tenantFileName =
                                                                value.file
                                                                    .first!
                                                                    .path
                                                                    .split('/')
                                                                    .last;
                                                          });
                                                          tenantBytes =
                                                          await tenantPic!
                                                              .readAsBytes();
                                                          print(
                                                              'MY PIC == $tenantPic');
                                                          print(
                                                              'MY path == $tenantImagePath');
                                                          print(
                                                              'MY bytes == $tenantBytes');
                                                          print(
                                                              'MY extension == $tenantImageExtension');
                                                          print(
                                                              'MY FILE NAME == $tenantFileName');
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 90.w,
                                                      height: 15.h,
                                                      decoration: BoxDecoration(
                                                          color: AppTheme
                                                              .appBgColor,
                                                          borderRadius: BorderRadius
                                                              .circular(15.sp),
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  tenantPic ??
                                                                      File('')),
                                                              fit: BoxFit.cover)
                                                      ),
                                                      child: tenantPic == null
                                                          ? Center(
                                                        child: Text(
                                                            'Upload profile pic'),)
                                                          : null,
                                                    ),
                                                  )


                                                  // AppTextField(
                                                  //   controller: individualDescriptionController,
                                                  //   hintText: 'Description',
                                                  //   obscureText: false,
                                                  //   keyBoardType: TextInputType.text,
                                                  //   validator: iDescriptionValidator,
                                                  // ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container();
                                      }),


                                      Obx(() {
                                        return widget.tenantController
                                            .tenantTypeId.value == 2
                                            ? SlideInUp(
                                          child: Container(
                                            child: Form(
                                              key: _companyFormKey,
                                              child: Column(
                                                children: [
                                                  Text('Company Details',
                                                    style: AppTheme.appTitle3,),

                                                  AuthTextField(
                                                    controller: companyNameController,
                                                    hintText: 'Business Name',
                                                    obscureText: false,
                                                    keyBoardType: TextInputType
                                                        .text,
                                                    // validator: companyNameValidator,
                                                  ),

                                                  SizedBox(height: 1.h,),

                                                  AuthTextField(
                                                    controller: companyDescriptionController,
                                                    hintText: 'Description',
                                                    obscureText: false,
                                                  ),

                                                  Obx(() {
                                                    return widget
                                                        .tenantController
                                                        .tenantTypeId.value == 1
                                                        ? Container()
                                                        : widget
                                                        .tenantController
                                                        .tenantTypeId.value == 2
                                                        ? CheckboxListTile(
                                                      value: widget
                                                          .tenantController
                                                          .isAddContactPerson
                                                          .value,
                                                      onChanged: (value) {
                                                        widget.tenantController
                                                            .addContactPerson(
                                                            value!);
                                                      },
                                                      activeColor: AppTheme
                                                          .primaryColor,
                                                      title: widget
                                                          .tenantController
                                                          .isAddContactPerson
                                                          .value
                                                          ? Text(
                                                        'remove Contact Person',
                                                        style: AppTheme
                                                            .subTextBold1,
                                                      )
                                                          : Text(
                                                        'add Contact Person',
                                                        style: AppTheme
                                                            .subTextBold1,
                                                      ),
                                                    )
                                                        : Container();
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container();
                                      }),

                                      Obx(() {
                                        return widget.tenantController
                                            .tenantTypeId.value == 2
                                            ? Bounceable(
                                          onTap: () {
                                            FullPicker(
                                              context: context,
                                              file: true,
                                              image: true,
                                              video: true,
                                              videoCamera: true,
                                              imageCamera: true,
                                              voiceRecorder: true,
                                              videoCompressor: false,
                                              imageCropper: false,
                                              multiFile: true,
                                              url: true,
                                              onError: (int value) {
                                                print(
                                                    " ----  onError ----=$value");
                                              },
                                              onSelected: (value) async {
                                                print(" ----  onSelected ----");

                                                setState(() {
                                                  companyTenantPic =
                                                      value.file.first;
                                                  companyTenantImagePath =
                                                      value.file.first!.path;
                                                  companyTenantImageExtension =
                                                      value.file.first!
                                                          .path
                                                          .split('.')
                                                          .last;
                                                  companyTenantFileName =
                                                      value.file.first!
                                                          .path
                                                          .split('/')
                                                          .last;
                                                });
                                                companyTenantBytes =
                                                await companyTenantPic!
                                                    .readAsBytes();
                                                print(
                                                    'MY Company PIC == $companyTenantPic');
                                                print(
                                                    'MY Company path == $companyTenantImagePath');
                                                print(
                                                    'MY Company bytes == $companyTenantBytes');
                                                print(
                                                    'MY Company extension == $companyTenantImageExtension');
                                                print(
                                                    'MY Company FILE NAME == $companyTenantFileName');
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 90.w,
                                            height: 15.h,
                                            decoration: BoxDecoration(
                                                color: AppTheme.appBgColor,
                                                borderRadius: BorderRadius
                                                    .circular(15.sp),
                                                image: DecorationImage(
                                                    image: FileImage(
                                                        companyTenantPic ??
                                                            File('')),
                                                    fit: BoxFit.cover)
                                            ),
                                            child: companyTenantPic == null ||
                                                companyTenantPic!.path.isEmpty
                                                ? Center(
                                              child: Text(
                                                  'Upload profile pic'),)
                                                : null,
                                          ),
                                        ) : Container();
                                      }),


                                      SizedBox(
                                        height: 2.h,
                                      ),

                                      // AppTextField(
                                      //   controller: otherNameController,
                                      //   hintText: 'Phone No:',
                                      //   obscureText: false,
                                      // ),
                                      //
                                      // SizedBox(height: 2.h,),
                                      //
                                      // SizedBox(
                                      //   height: 15.h,
                                      //   width: 90.w,
                                      //   child: DottedBorder(
                                      //     borderType: BorderType.RRect,
                                      //     strokeWidth: 1,
                                      //     radius: Radius.circular(20.sp),
                                      //     child: _image.path == '' ?
                                      //     Center(child: Bounceable(
                                      //       onTap: () async {
                                      //         await pickImage();
                                      //       },
                                      //       child: Center(
                                      //         child: Container(
                                      //             height: 29.5.h,
                                      //             width: 77.5.w,
                                      //             decoration: BoxDecoration(
                                      //                 borderRadius: BorderRadius.circular(20.sp)
                                      //             ),
                                      //             child: Row(
                                      //               mainAxisAlignment: MainAxisAlignment.center,
                                      //               crossAxisAlignment: CrossAxisAlignment.center,
                                      //               children: [
                                      //                 Center(child: Image.asset(
                                      //                     'assets/general/upload.png')),
                                      //                 SizedBox(width: 3.w,),
                                      //                 Text('Upload Picture', style: AppTheme.subText)
                                      //               ],
                                      //             )),
                                      //       ),
                                      //     ),)
                                      //         : Center(
                                      //       child: Container(
                                      //         clipBehavior: Clip.antiAlias,
                                      //         height: 29.5.h,
                                      //         width: 77.5.w,
                                      //         decoration: BoxDecoration(
                                      //           // color: AppTheme.borderColor2,
                                      //             borderRadius: BorderRadius.circular(20.sp)
                                      //         ),
                                      //         child: Stack(
                                      //           children: [
                                      //             Center(
                                      //               child: Image(image: FileImage(_image),
                                      //                 fit: BoxFit.cover,
                                      //               ),
                                      //             ),
                                      //             Align(
                                      //                 alignment: Alignment.topRight,
                                      //                 child: Padding(
                                      //                   padding: EdgeInsets.only(
                                      //                       right: 2.w, top: 2.h),
                                      //                   child: Bounceable(
                                      //                       onTap: () {
                                      //                         setState(() {
                                      //                           _image = File('');
                                      //                         });
                                      //                       },
                                      //                       child: Icon(Icons.cancel, size: 25.sp,
                                      //                         color: AppTheme.primaryColor,)),
                                      //                 ))
                                      //           ],
                                      //         ),),
                                      //     ),
                                      //   ),
                                      // ),
                                      //
                                      // imageError == '' ? Container() : Padding(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 3.w, vertical: 0.5.h),
                                      //   child: Text(imageError, style: TextStyle(
                                      //     fontSize: 14.sp,
                                      //     color: Colors.red.shade800,
                                      //
                                      //   ),),
                                      // ),


                                      Obx(() {
                                        return widget.tenantController
                                            .isAddContactPerson.value &&
                                            widget.tenantController.tenantTypeId
                                                .value == 2
                                            ? TenantProfileContactForm(
                                          contactKey: _contactFormKey,
                                          contactFirstNameController:
                                          contactFirstNameController,
                                          contactLastNameController: contactLastNameController,
                                          contactNinController: contactNinController,
                                          contactDesignationController:
                                          contactDesignationController,
                                          contactPhoneController: contactPhoneController,
                                          contactEmailController: contactEmailController,
                                          designationValidator: contactDesignationValidator,
                                          emailValidator: contactEmailValidator,
                                          firstNameValidator: contactFirstNameValidator,
                                          lastNameValidator: contactLastNameValidator,
                                          ninValidator: contactNinValidator,
                                          phoneValidator: contactPhoneValidator,

                                        )
                                            : Container();
                                      }),

                                      // SizedBox(
                                      //   height: 2.h,
                                      // ),


                                    ],
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        }
    );

    print(result); // This is the result.
  }

}
