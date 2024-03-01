import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:full_picker/full_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/data_source/models/nation/nation_model.dart';
import 'package:smart_rent/data_source/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/pages/floor/widgets/tenant_card_widget.dart';
import 'package:smart_rent/pages/nation/bloc/nation_bloc.dart';
import 'package:smart_rent/pages/tenant/bloc/tenant_bloc.dart';
import 'package:smart_rent/pages/tenant/tenant_details_page.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/tenant_profile_contact_form.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class TenantListScreenLayout extends StatefulWidget {
  final TenantController tenantController;

  const TenantListScreenLayout({super.key, required this.tenantController});

  @override
  State<TenantListScreenLayout> createState() => _TenantListScreenLayoutState();
}

class _TenantListScreenLayoutState extends State<TenantListScreenLayout> {
  // final TenantController tenantController = Get.put(TenantController(), permanent: true);

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
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController tinNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
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

  final cBusinessNameValidator = MultiValidator([
    RequiredValidator(errorText: 'business name required'),
    MinLengthValidator(3, errorText: 'business name too short'),
    MaxLengthValidator(50, errorText: 'business name too long'),
  ]);

  final iNinValidator = MultiValidator([
    RequiredValidator(errorText: 'NIN required'),
    MinLengthValidator(10, errorText: 'NIN too short'),
    MaxLengthValidator(12, errorText: 'NIN too long'),
  ]);

  final iEmailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'input does\'nt match email'),
  ]);

  final iFirstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'first name required'),
    MinLengthValidator(2, errorText: 'first name too short'),
    MaxLengthValidator(15, errorText: 'first name too long'),
  ]);

  final iLastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'last name required'),
    MinLengthValidator(2, errorText: 'last name too short'),
    MaxLengthValidator(15, errorText: 'last name too long'),
  ]);

  final iPhoneValidator = MultiValidator([
    RequiredValidator(errorText: 'contact required'),
    MinLengthValidator(10, errorText: 'contact short'),
    MaxLengthValidator(15, errorText: 'contact too long'),
  ]);

  final iDescriptionValidator = MultiValidator([
    MaxLengthValidator(500, errorText: 'descrition too long'),
  ]);

  final companyDescriptionValidator = MultiValidator([
    MaxLengthValidator(500, errorText: 'descrition too long'),
  ]);

  //
  // final iSalutationValidator = MultiValidator([
  //   RequiredValidator(errorText: 'salutation required'),
  // ]);

  final iSalutationValidator =
      RequiredValidator(errorText: 'salutation required');

  final iGenderValidator = MultiValidator([
    RequiredValidator(errorText: 'gender required'),
  ]);

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

  var typeList = [
    'Individual',
    'Company',
    'Family',
  ];

  var sexList = [
    'Mr',
    'Mrs',
  ];

  var genderList = [
    'Male',
    'Female',
  ];

  String imageError = '';

  final ImagePicker _picker = ImagePicker();
  late File _image;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File? img = File(image.path);
      setState(() {
        // newFile = img;
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

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
      minDate: DateTime(1900),
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
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppImageHeader(
        title: 'assets/auth/srw.png',
        isTitleCentred: true,
      ),
      floatingActionButtonLocation:
          userStorage.read('roleId') == 4 ? null : ExpandableFab.location,
      floatingActionButton: userStorage.read('roleId') == 4
          ? Container()
          : ExpandableFab(
              key: _tenantKey,
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
              children: [],
              onOpen: () {
                final state = _tenantKey.currentState;
                if (state != null) {
                  debugPrint('isOpen:${state.isOpen}');
                  state.toggle();
                }
                showAddTenantBottomSheet(context);
              },
            ),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 0.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tenants',
                          style: AppTheme.appTitle5,
                        ),
                        Text(
                          'Manage your tenants',
                          style: AppTheme.subText,
                        ),
                      ],
                    ),
                  ),
                  // userStorage.read('roleId') == 4 ? Container() : Bounceable(
                  //     onTap: () {
                  //       showAddPTenantBottomSheet(context);
                  //       // Get.to(() => AddTenantScreen(),
                  //       //     transition: Transition.downToUp);
                  //     },
                  //   child: Container(
                  //     width: 10.w,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.sp),
                  //       color: AppTheme.primaryColor,
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Center(
                  //         child: Icon(Icons.add, color: Colors.white,),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              BlocBuilder<TenantBloc, TenantState>(
                builder: (context, state) {
                  if (state.status == TenantStatus.initial) {
                    context.read<TenantBloc>().add(LoadAllTenantsEvent());
                  }
                  if (state.status == TenantStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == TenantStatus.success) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.tenants!.length,
                        itemBuilder: (context, index) {
                          var tenant = state.tenants![index];
                          return Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: SlideInUp(
                                child: Bounceable(
                              onTap: () {
                                Get.to(() => TenantDetailsPage(id: tenant.id!));
                              },
                              child: TenantCardWidget(
                                tenantModel: tenant,
                                index: index,
                                deleteFunction: () async {
                                  // if(  tenant.tenantTypeId == 2){
                                  //   widget.tenantController.deleteCompanyTenant(tenant.id);
                                  // } else {
                                  //   widget.tenantController.deleteTenant(tenant.id);
                                  // }
                                },
                                editFunction: () {
                                  // if(  tenant.tenantTypeId == 2){
                                  //   Get.to(() => UpdateCompanyTenantWithContactScreen(tenantModel: tenant));
                                  // } else {
                                  //   Get.to(() => UpdateIndividualTenantScreen(tenantModel: tenant));
                                  // }
                                },
                              ),
                            )),
                          );
                        });
                  }
                  if (state.status == TenantStatus.empty) {
                    return const Center(
                      child: Text('No Tenants'),
                    );
                  }
                  if (state.status == TenantStatus.error) {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  }
                  return Container();
                },
              ),

              // Obx(() {
              //   return widget.tenantController.isTenantListLoading.value
              //       ? Center(child: CircularProgressIndicator())
              //       : ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: widget.tenantController.tenantList.length,
              //       itemBuilder: (context, index) {
              //         var tenant = widget.tenantController.tenantList[index];
              //         return Padding(
              //           padding: EdgeInsets.only(top: 1.h),
              //           child: SlideInUp(
              //               child: Bounceable(
              //                 onTap: (){
              //                   Get.to(() => TenantDetailsScreen(
              //                     tenantController: widget.tenantController,
              //                     tenantId: tenant.id,
              //                     tenantModel: tenant,
              //                   ));
              //                 },
              //                 child: TenantCardWidget(
              //             tenantModel: tenant,
              //             tenantController: widget.tenantController,
              //             index: index,
              //             deleteFunction: ()async {
              //               if(  tenant.tenantTypeId == 2){
              //                 widget.tenantController.deleteCompanyTenant(tenant.id);
              //               } else {
              //                 widget.tenantController.deleteTenant(tenant.id);
              //               }
              //             },
              //             editFunction: () {
              //             if(  tenant.tenantTypeId == 2){
              //                 Get.to(() => UpdateCompanyTenantWithContactScreen(tenantModel: tenant));
              //             } else {
              //                 Get.to(() => UpdateIndividualTenantScreen(tenantModel: tenant));
              //             }
              //             },
              //                 ),
              //               )),
              //         );
              //       });
              // }),
            ],
          ),
        ),
      ),
    );
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
                  BlocProvider<TenantBloc>(
                    create: (context) => TenantBloc(),
                  ),
                  BlocProvider<NationBloc>(
                    create: (context) => NationBloc(),
                  )
                ],
                child: Material(
                  color: AppTheme.whiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                BlocBuilder<TenantBloc, TenantState>(
                                  builder: (context, state) {
                                    if (state.status == TenantStatus.initial) {
                                      context
                                          .read<TenantBloc>()
                                          .add(LoadTenantTypes());
                                    }
                                    return CustomApiGenericDropdown<
                                        TenantTypeModel>(
                                      hintText: 'Select Tenant Type',
                                      menuItems: state.tenantTypes == null
                                          ? []
                                          : state.tenantTypes!,
                                      onChanged: (value) {},
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
                                    if (state.status == NationStatus.initial) {
                                      context
                                          .read<NationBloc>()
                                          .add(LoadNationsEvent());
                                    }
                                    return CustomApiGenericDropdown<
                                        NationModel>(
                                      hintText: 'Country',
                                      menuItems: state.nations == null
                                          ? []
                                          : state.nations!,
                                      onChanged: (value) {},
                                    );
                                  },
                                ),

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
                                                  controller:
                                                      firstNameController,
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
                                                  print(
                                                      " ----  onSelected ----");

                                                  setState(() {
                                                    tenantPic =
                                                        value.file.first;
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
                                                  color:
                                                      AppTheme.appWidgetColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.sp),
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          tenantPic ??
                                                              File('')),
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
                                            controller:
                                                companyAddressController,
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
                                                    style:
                                                        AppTheme.subTextBold1,
                                                  )
                                                : Text(
                                                    'add Contact Person',
                                                    style:
                                                        AppTheme.subTextBold1,
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
                                  contactPhoneController:
                                      contactPhoneController,
                                  contactEmailController:
                                      contactEmailController,
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
