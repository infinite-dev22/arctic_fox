import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/complaints/complaints_controller.dart';
import 'package:smart_rent/data_source/models/nation/nation_model.dart';
import 'package:smart_rent/data_source/models/property/general.dart';
import 'package:smart_rent/data_source/models/property/property_category_model.dart';
import 'package:smart_rent/data_source/models/property/property_response_model.dart';
import 'package:smart_rent/data_source/models/property/property_types_model.dart';
import 'package:smart_rent/data_source/models/tenant/tenant_model.dart';
import 'package:smart_rent/data_source/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/pages/floor/bloc/floor_bloc.dart';
import 'package:smart_rent/pages/home/bloc/home_bloc.dart';
import 'package:smart_rent/pages/nation/bloc/nation_bloc.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/pages/property/property_list_screen.dart';
import 'package:smart_rent/pages/property_categories/bloc/property_category_bloc.dart';
import 'package:smart_rent/pages/property_types/bloc/property_type_bloc.dart';
import 'package:smart_rent/pages/tenant/bloc/tenant_bloc.dart';
import 'package:smart_rent/pages/tenant/tenant_list_page.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/complaints_widget.dart';
import 'package:smart_rent/widgets/home_card_widget1.dart';
import 'package:smart_rent/widgets/home_card_widget2.dart';
import 'package:smart_rent/widgets/tenant_profile_contact_form.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({super.key});

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  // final PropertyController propertyController = Get.put(PropertyController());

  late SingleValueDropDownController _propertyModelCont;

  final TextEditingController floorController = TextEditingController();
  final TextEditingController floorCodeController = TextEditingController();
  final TextEditingController propertyDescriptionController =
      TextEditingController();
  String? floorName;

  final _propertyKey = GlobalKey<ExpandableFabState>();

  File? propertyPic;
  String? propertyImagePath;
  String? propertyImageExtension;
  String? propertyFileName;
  Uint8List? propertyBytes;

  final TextEditingController propertyTitleController = TextEditingController();
  final TextEditingController propertyAddressController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController propertyLocationController =
      TextEditingController();
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
  final TextEditingController companyBranchController = TextEditingController();
  final TextEditingController companyEmailController = TextEditingController();
  final TextEditingController companyTinController = TextEditingController();
  final TextEditingController companyAddressController =
      TextEditingController();
  final TextEditingController companyDescriptionController =
      TextEditingController();

  final TextEditingController individualFirstNameController =
      TextEditingController();
  final TextEditingController individualLastNameController =
      TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController tinNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController individualEmailNameController =
      TextEditingController();
  final TextEditingController individualPhoneNameController =
      TextEditingController();
  final TextEditingController individualDateOfBirthController =
      TextEditingController();
  final TextEditingController individualNinController = TextEditingController();
  final TextEditingController individualDescriptionController =
      TextEditingController();
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

  int? selectedPropertyTypeId;
  int? selectedPropertyCategoryId;

  final propertyTypes = PropertyTypeG.propertyTypes;
  final propertyCategoryTypes = PropertyCategoryTypeG.propertyCategoryTypes;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _propertyModelCont = SingleValueDropDownController();
    // propertyController.fetchAllPropertyTypes();
    print('My AccessToken ${userStorage.read('accessToken').toString()}');
  }

  int? selectedPropertyId;

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
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
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
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    final _key = GlobalKey<ExpandableFabState>();
    // final UserController userController = Get.put(
    //     UserController(),);
    final ComplaintsController complaintsController =
        Get.put(ComplaintsController());
    // final TenantController tenantController = Get.put(
    //   TenantController(),
    // );
    // final UnitController unitController =
    // Get.put(UnitController(), permanent: true);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        floatingActionButtonLocation:
            userStorage.read('roleId') == 4 ? null : ExpandableFab.location,
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
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
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
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
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

                        showAddTenantBottomSheet(context);
                  
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 3.w,
                              ),
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
                              SizedBox(
                                width: 3.w,
                              ),
                              Text('Add Property',
                                  style: AppTheme.subTextBold2)
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
                                      SizedBox(
                                        width: 90.w,
                                        child: BlocBuilder<PropertyBloc,
                                            PropertyState>(
                                          // bloc: PropertyBloc(),
                                          builder: (context, state) {
                                            if (state.status ==
                                                PropertyStatus.initial) {
                                              context
                                                  .read<PropertyBloc>()
                                                  .add(
                                                      LoadPropertiesEvent());
                                            }
                                            if (state.status ==
                                                PropertyStatus.empty) {
                                              return Center(child: Text('No Tenants'),);
                                            }  if (state.status ==
                                                PropertyStatus.error) {
                                              return Center(child: Text('An Error Occurred'),);
                                            }
                                            return SearchablePropertyModelListDropDown<
                                                Property>(
                                              hintText: 'Property',
                                              menuItems: state.properties == null ? [] : state.properties! ,
                                              controller:
                                              _propertyModelCont,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPropertyId = value.value.id;
                                                });
                                                print('Property is $selectedPropertyId}');
                                              },
                                            );



                                          },
                                        ),
                                      ),
                                      AuthTextField(
                                        controller: floorController,
                                        hintText: 'Floor No.',
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
                                      AuthTextField(
                                        controller: floorCodeController,
                                        hintText: 'Code.',
                                        obscureText: false,
                                        onChanged: (value) {
                                          // floorName = floorController.text.trim();
                                          print(floorCodeController.text
                                              .toString());
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
                                                  selectedPropertyId!,
                                                  floorController.text.trim().toString(),
                                                  floorCodeController.text.trim().toString(),
                                                  descriptionController.text.trim().toString(),
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
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.meeting_room),
                              SizedBox(
                                width: 3.w,
                              ),
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
        appBar: AppImageHeader(
          leading: Container(),
          title: 'assets/auth/srw.png',
          isTitleCentred: true,
          actions: [
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state.status == HomeStatus.successLogout) {
                  Fluttertoast.showToast(msg: 'LoggedOut Successfully', backgroundColor: Colors.green, gravity: ToastGravity.TOP);
                  Get.offAll(() => InitialScreen());
                } if (state.status == HomeStatus.error) {
                  Fluttertoast.showToast(
                      msg: state.message.toString(),gravity: ToastGravity.TOP);
                }

                },
              child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return PopupMenuButton(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Image.asset(
                      'assets/home/sidely.png',
                      color: Colors.white,
                    ),
                  ),
                  onSelected: (value) async {
                    if (value == 1) {
                      context.read<HomeBloc>().add(
                          LogoutUserEvent(userStorage.read('accessToken')));
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
                );
              },
            ),
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
                    userStorage.read('userFirstname') == null
                        ? ZoomIn(
                            child: SizedBox(
                              child: Text(
                                'User',
                                style: AppTheme.blueAppTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              width: 47.5.w,
                            ),
                            delay: Duration(seconds: 0),
                          )
                        : ZoomIn(
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
                            ),
                            delay: Duration(seconds: 0),
                          )
                  ],
                ),
                // Text(userController.userFirstname.value),

                SizedBox(
                  height: 1.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<PropertyBloc, PropertyState>(
                      builder: (context, state) {
                        if (state.status == PropertyStatus.initial) {
                          context
                              .read<PropertyBloc>()
                              .add(LoadPropertiesEvent());
                        }
                        return HomeCardWidget1(
                          color: AppTheme.greenCardColor,
                          total: state.properties == null
                              ? 0
                              : state.properties!.length,
                          title: 'Total Property',
                          function: () {
                            Get.to(() => PropertyListPage());
                          },
                        );
                      },
                    ),
                    BlocBuilder<TenantBloc, TenantState>(
                      builder: (context, state) {
                        if (state.status == TenantStatus.initial) {
                          context
                              .read<TenantBloc>()
                              .add(LoadAllTenantsEvent());
                        }

                        return HomeCardWidget1(
                          color: AppTheme.redCardColor,
                          total: state.tenants == null
                              ? 0
                              : state.tenants!.length,
                          title: 'Total Tenants',
                          function: () {
                            Get.to(() => TenantListPage());
                          },
                        );
                      },
                    ),
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
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        extendBody: false,
        maxWidth: 90.h,
        duration: Duration(microseconds: 1),
        minHeight: 90.h,
        elevation: 8,
        cornerRadius: 15.sp,
        snapSpec: const SnapSpec(
          snap: false,
          snappings: [0.9],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (context, setState) {
          return BlocProvider<PropertyBloc>(
  create: (context) => PropertyBloc(),
  child: Material(
            elevation: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 7.5.h,
              decoration: BoxDecoration(boxShadow: []),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Bounceable(
                        onTap: () {
                          propertyTitleController.clear();
                          propertyAddressController.clear();
                          propertyDescriptionController.clear();
                          propertyLocationController.clear();
                          propertySqmController.clear();
                          propertyPic = File('');
                          print('Pic = ${propertyPic!.path}');

                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17.5.sp,
                          ),
                        )),
                    Text(
                      'Add Property',
                      style: AppTheme.darkBlueTitle2,
                    ),
                    BlocListener<PropertyBloc, PropertyState>(
                      listener: (context, state) {
                        if (state.status == PropertyStatus.successAdd) {
                          Fluttertoast.showToast(msg: 'Property Added Successfully', backgroundColor: Colors.green, gravity: ToastGravity.TOP);
                          Navigator.pop(context);
                        }
                        if (state.status == PropertyStatus.accessDeniedAdd) {
                          Fluttertoast.showToast(
                              msg: state.message.toString(),gravity: ToastGravity.TOP);
                        }if (state.status == PropertyStatus.errorAdd) {
                          Fluttertoast.showToast(
                              msg: state.message.toString(),gravity: ToastGravity.TOP);
                        }
                        },
                      child: BlocBuilder<PropertyBloc, PropertyState>(
                      builder: (context, state) {
                        if (state.status == PropertyStatus.loadingDetails) {
                          return CircularProgressIndicator();
                        }
                      return Bounceable(
                        onTap: () async {
                          if (propertyTitleController.text.isEmpty ||
                              propertyLocationController.text.isEmpty ||
                              propertySqmController.text.isEmpty
                              // propertyPic == null
                          ) {
                            Fluttertoast.showToast(
                                msg: 'fill in all fields',
                                gravity: ToastGravity.TOP);
                          } else {

                            context.read<PropertyBloc>().add(AddPropertyEvent(
                              userStorage.read('accessToken').toString(),
                                propertyTitleController.text.trim().toString(),
                                propertyLocationController.text.trim().toString(),
                                propertySqmController.text.trim().toString(),
                                descriptionController.text.trim().toString(),
                                selectedPropertyTypeId!,
                                selectedPropertyCategoryId!,
                            ));

                            // propertyTitleController.clear();
                            // propertyAddressController.clear();
                            // propertyDescriptionController.clear();
                            // propertyLocationController.clear();
                            // propertySqmController.clear();
                            // propertyPic = File('');
                            // print('Pic = ${propertyPic!.path}');
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 17.5.sp,
                          ),
                        ));
  },
),
),
                  ],
                ),
              ),
            ),
          ),
);
        },
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
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<PropertyCategoryBloc>(create: (_) => PropertyCategoryBloc()..add(LoadAllPropertyCategoriesEvent())),
                  BlocProvider<PropertyTypeBloc>(create: (_) => PropertyTypeBloc()..add(LoadAllPropertyTypesEvent())),
                ],
                child: Material(
                  color: AppTheme.whiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AuthTextField(
                                controller: propertyTitleController,
                                hintText: 'Property title',
                                obscureText: false,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 42.5.w,
                                    child: BlocBuilder<PropertyTypeBloc, PropertyTypeState>(
                                      builder: (context, state) {
                                        return CustomApiGenericDropdown<PropertyTypeModel>(
                                      hintText: 'Type',
                                      menuItems: state.propertyTypes == null ? [] : state.propertyTypes!,
                                      onChanged: (value) {
                                        setState((){
                                          selectedPropertyTypeId = value!.id!;
                                        });
                                        print(value!.id);
                                      },
                                    );
                  },
                ),
                                  ),
                                  SizedBox(
                                    width: 42.5.w,
                                    child: BlocBuilder<PropertyCategoryBloc, PropertyCategoryState>(
                                      builder: (context, state) {
                                        return CustomApiGenericDropdown<
                                            PropertyCategoryModel>(
                                      hintText: 'Category',
                                      menuItems: state.propertyCategories == null ? [] : state.propertyCategories!,
                                      onChanged: (value) {
                                        print(value!.id);
                                        setState((){
                                          selectedPropertyCategoryId = value.id!;
                                        });
                                      },
                                    );
                  },
                ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: 1.h,
                              ),
                              AppMaxTextField(
                                controller: propertyDescriptionController,
                                hintText: 'Description',
                                obscureText: false,
                                fillColor: AppTheme.appWidgetColor,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Bounceable(
                                onTap: () {
                                  FullPicker(
                                    prefixName: 'add property',
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
                                        propertyImageExtension = value
                                            .file.first!.path
                                            .split('.')
                                            .last;
                                        propertyFileName = value.file.first!.path
                                            .split('/')
                                            .last;
                                      });
                                      propertyBytes =
                                          await propertyPic!.readAsBytes();
                                      print('MY PIC == $propertyPic');
                                      print('MY path == $propertyImagePath');
                                      print('MY bytes == $propertyBytes');
                                      print(
                                          'MY extension == $propertyImageExtension');
                                      print('MY FILE NAME == $propertyFileName');
                                    },
                                  );
                                },
                                child: Container(
                                  width: 50.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                      color: AppTheme.appWidgetColor,
                                      borderRadius: BorderRadius.circular(15.sp),
                                      image: DecorationImage(
                                          image:
                                              FileImage(propertyPic ?? File('')),
                                          fit: BoxFit.cover)),
                                  child: propertyPic == null ||
                                          propertyPic!.path.isEmpty
                                      ? Center(
                                          child: Text('Upload profile pic'),
                                        )
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
              ),
            );
          });
        },
      );
    });

    print(result); // This is the result.
  }

  void showAddTenantBottomSheet(BuildContext context) async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        extendBody: false,
        maxWidth: 90.h,
        duration: Duration(microseconds: 1),
        minHeight: 90.h,
        elevation: 8,
        cornerRadius: 15.sp,
        snapSpec: const SnapSpec(
          snap: false,
          snappings: [0.9],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (context, state) {
          return Material(
          elevation: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 7.5.h,
            decoration: BoxDecoration(boxShadow: []),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Bounceable(
                      onTap: () {
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
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 17.5.sp,
                        ),
                      )),
                  Text(
                    'Add Tenant',
                    style: AppTheme.darkBlueTitle2,
                  ),
                  Bounceable(
                      onTap: () async {
                        var t = 0;
                        if (t == 10) {
                          Fluttertoast.showToast(
                              msg: 'Select Tenant Type',
                              gravity: ToastGravity.TOP);
                        } else {
                          if (t == 1) {
                            if (_formKey.currentState!.validate() &&
                                _individualFormKey.currentState!.validate()) {
                              // Get.snackbar(
                              //     'Posting Individual', 'Adding Individual Tenant');
                              if (tenantPic == null) {
                                Fluttertoast.showToast(
                                    msg: 'Tenant pic required',
                                    gravity: ToastGravity.TOP);
                              } else {
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
                                Get.back();
                              }

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
                                  msg: 'Fill required fields',
                                  gravity: ToastGravity.TOP);
                            }
                          } else {
                            var t = 0;
                            if (t == 1) {
                              if (_formKey.currentState!.validate() &&
                                  _companyFormKey.currentState!.validate()) {
                                // Get.snackbar(
                                //     'Posting Company', 'No Company Contact');
                                if (tenantPic == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Tenant pic required',
                                      gravity: ToastGravity.TOP);
                                } else {
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
                                  Get.back();
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Fill in fields',
                                    gravity: ToastGravity.TOP);
                              }
                            } else {
                              if (_formKey.currentState!.validate() &&
                                  _companyFormKey.currentState!.validate() &&
                                  _contactFormKey.currentState!.validate()) {
                                // Get.snackbar(
                                //     'Posting Company', 'With Company Contact');
                                if (companyTenantPic == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Company tenant pic required',
                                      gravity: ToastGravity.TOP);
                                } else {
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
                                  Get.back();
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Fill in fields',
                                    gravity: ToastGravity.TOP);
                              }
                            }
                          }
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 17.5.sp,
                        ),
                      )),
                ],
              ),
            ),
          ),
                    );
        },
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
              child: MultiBlocProvider(
                providers: [
              BlocProvider<TenantBloc>(create: (context) => TenantBloc(),),
              BlocProvider<NationBloc>(create: (context) => NationBloc(),),
                ],
                child: Material(
                  color: AppTheme.whiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                BlocBuilder<TenantBloc, TenantState>(
                                  builder: (context, state) {
                                    if(state.status == TenantStatus.initial){
                                      context.read<TenantBloc>().add(LoadTenantTypes());
                                    }
                                    return CustomApiGenericDropdown<TenantTypeModel>(
                                  hintText: 'Select Tenant Type',
                                  menuItems: state.tenantTypes == null ? [] : state.tenantTypes!,
                                  onChanged: (value) {

                                  },
                                );
                  },
                ),
                                SizedBox(
                                  height: 1.h,
                                ),

                                CustomApiGenericDropdown<BusinessTypeModel>(
                                  hintText: "Business Type",
                                  menuItems: [],
                                  onChanged: (value) {},
                                ),

                                SizedBox(
                                  height: 1.h,
                                ),

                                BlocBuilder<NationBloc, NationState>(
                                  builder: (context, state) {
                                    if(state.status == NationStatus.initial){
                                      context.read<NationBloc>().add(LoadNationsEvent());
                                    }
                                    return CustomApiGenericDropdown<NationModel>(
                                      hintText: 'Country',
                                      menuItems: state.nations == null ? [] : state.nations!,
                                      onChanged: (value) {},
                                    );
                                  },),

                                SlideInUp(
                                  child: Container(
                                    child: Form(
                                      key: _individualFormKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Personal Details',
                                            style: AppTheme.appTitle3,
                                          ),
                                          CustomApiGenericDropdown<
                                              SalutationModel>(
                                            hintText: 'Mr',
                                            menuItems: [],
                                            onChanged: (value) {},
                                            height: 6.5.h,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 42.5.w,
                                                child: AuthTextField(
                                                  controller: firstNameController,
                                                  hintText: 'First Name',
                                                  obscureText: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  // validator: iFirstNameValidator,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 42.5.w,
                                                child: AuthTextField(
                                                  controller:
                                                      surnameNameController,
                                                  hintText: 'Surname',
                                                  obscureText: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  // validator: iLastNameValidator,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller: middleNameController,
                                            hintText: 'Middle Name',
                                            obscureText: false,
                                            keyBoardType: TextInputType.text,
                                            // validator: iFirstNameValidator,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller:
                                                individualEmailNameController,
                                            hintText: 'Email',
                                            obscureText: false,
                                            keyBoardType:
                                                TextInputType.emailAddress,
                                            // validator: iEmailValidator,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller:
                                                individualPhoneNameController,
                                            hintText: 'Contact',
                                            obscureText: false,
                                            keyBoardType: TextInputType.number,
                                            // validator: iPhoneValidator,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller:
                                                individualDateOfBirthController,
                                            hintText: 'D.O.B',
                                            obscureText: false,
                                            onTap: () {
                                              _selectDateOfBirth(context);
                                            },
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          CustomGenericDropdown(
                                            hintText: 'Branch',
                                            menuItems: [],
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller: idNumberController,
                                            hintText: 'ID Number',
                                            obscureText: false,
                                            keyBoardType: TextInputType.number,
                                            // validator: iFirstNameValidator,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller: individualNinController,
                                            hintText: 'NIN',
                                            obscureText: false,
                                            keyBoardType: TextInputType.text,
                                            // validator: iNinValidator,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller: tinNumberController,
                                            hintText: 'Tin Number',
                                            obscureText: false,
                                            keyBoardType: TextInputType.number,
                                            // validator: iFirstNameValidator,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          CustomGenericDropdown<String>(
                                            hintText: 'Gender',
                                            menuItems: [],
                                            onChanged: (value) {},
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          AuthTextField(
                                            controller: addressController,
                                            hintText: 'Address',
                                            obscureText: false,
                                            keyBoardType:
                                                TextInputType.streetAddress,
                                            // validator: iFirstNameValidator,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          DescriptionTextField(
                                            controller:
                                                individualDescriptionController,
                                            hintText: 'Description',
                                            obscureText: false,
                                          ),

                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          Bounceable(
                                            onTap: () {
                                              FullPicker(
                                                prefixName: 'add tenant',
                                                context: context,
                                                image: true,
                                                imageCamera: kDebugMode,
                                                imageCropper: true,
                                                onError: (int value) {
                                                  print(
                                                      " ----  onError ----=$value");
                                                },
                                                onSelected: (value) async {
                                                  print(" ----  onSelected ----");

                                                  setState(() {
                                                    tenantPic = value.file.first;
                                                    tenantImagePath =
                                                        value.file.first!.path;
                                                    tenantImageExtension = value
                                                        .file.first!.path
                                                        .split('.')
                                                        .last;
                                                    tenantFileName = value
                                                        .file.first!.path
                                                        .split('/')
                                                        .last;
                                                  });
                                                  tenantBytes = await tenantPic!
                                                      .readAsBytes();
                                                  print('MY PIC == $tenantPic');
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
                                              width: 50.w,
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.appWidgetColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.sp),
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          tenantPic ?? File('')),
                                                      fit: BoxFit.cover)),
                                              child: tenantPic == null
                                                  ? Center(
                                                      child: Text(
                                                          'Upload profile pic'),
                                                    )
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
                                ),

                                SlideInUp(
                                  child: Container(
                                    child: Form(
                                      key: _companyFormKey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Company Details',
                                            style: AppTheme.appTitle3,
                                          ),
                                          AuthTextField(
                                            controller: companyNameController,
                                            hintText: 'Business Name',
                                            obscureText: false,
                                            keyBoardType: TextInputType.text,
                                            // validator: companyNameValidator,
                                          ),
                                          SizedBox(height: 1.h),
                                          AuthTextField(
                                            controller: companyBranchController,
                                            hintText: 'Branch',
                                            obscureText: false,
                                            keyBoardType: TextInputType.text,
                                          ),
                                          SizedBox(height: 1.h),
                                          AuthTextField(
                                            controller: companyEmailController,
                                            hintText: 'Email',
                                            obscureText: false,
                                            keyBoardType:
                                                TextInputType.emailAddress,
                                          ),
                                          SizedBox(height: 1.h),
                                          AuthTextField(
                                            controller: companyTinController,
                                            hintText: 'Tin Number',
                                            obscureText: false,
                                            keyBoardType: TextInputType.number,
                                          ),
                                          SizedBox(height: 1.h),
                                          AuthTextField(
                                            controller: companyAddressController,
                                            hintText: 'Address',
                                            obscureText: false,
                                            keyBoardType:
                                                TextInputType.streetAddress,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          DescriptionTextField(
                                            controller:
                                                companyDescriptionController,
                                            hintText: 'Description',
                                            obscureText: false,
                                          ),
                                          CheckboxListTile(
                                            value: true,
                                            onChanged: (value) {},
                                            activeColor: AppTheme.primaryColor,
                                            title: true
                                                ? Text(
                                                    'remove Contact Person',
                                                    style: AppTheme.subTextBold1,
                                                  )
                                                : Text(
                                                    'add Contact Person',
                                                    style: AppTheme.subTextBold1,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Bounceable(
                                  onTap: () {
                                    FullPicker(
                                      prefixName: 'add tenant',
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
                                          companyTenantPic = value.file.first;
                                          companyTenantImagePath =
                                              value.file.first!.path;
                                          companyTenantImageExtension = value
                                              .file.first!.path
                                              .split('.')
                                              .last;
                                          companyTenantFileName = value
                                              .file.first!.path
                                              .split('/')
                                              .last;
                                        });
                                        companyTenantBytes =
                                            await companyTenantPic!.readAsBytes();
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
                                    width: 50.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                        color: AppTheme.appWidgetColor,
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        image: DecorationImage(
                                            image: FileImage(
                                                companyTenantPic ?? File('')),
                                            fit: BoxFit.cover)),
                                    child: companyTenantPic == null ||
                                            companyTenantPic!.path.isEmpty
                                        ? Center(
                                            child: Text('Upload profile pic'),
                                          )
                                        : null,
                                  ),
                                ),

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

                                TenantProfileContactForm(
                                  contactKey: _contactFormKey,
                                  contactFirstNameController:
                                      contactFirstNameController,
                                  contactLastNameController:
                                      contactLastNameController,
                                  contactNinController: contactNinController,
                                  contactDesignationController:
                                      contactDesignationController,
                                  contactPhoneController: contactPhoneController,
                                  contactEmailController: contactEmailController,
                                  designationValidator:
                                      contactDesignationValidator,
                                  emailValidator: contactEmailValidator,
                                  firstNameValidator: contactFirstNameValidator,
                                  lastNameValidator: contactLastNameValidator,
                                  ninValidator: contactNinValidator,
                                  phoneValidator: contactPhoneValidator,
                                ),

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
              ),
            );
          });
        },
      );
    });

    print(result); // This is the result.
  }
}
