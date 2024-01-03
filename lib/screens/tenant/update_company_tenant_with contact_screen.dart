import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/tenant_profile_contact_form.dart';
import 'package:smart_rent/widgets/update_tenant_profile_contact_form.dart';

class UpdateCompanyTenantWithContactScreen extends StatefulWidget {
  final TenantModel tenantModel;

  const UpdateCompanyTenantWithContactScreen(
      {super.key, required this.tenantModel});

  @override
  State<UpdateCompanyTenantWithContactScreen> createState() =>
      _UpdateCompanyTenantWithContactScreenState();
}

class _UpdateCompanyTenantWithContactScreenState
    extends State<UpdateCompanyTenantWithContactScreen> {


  late TextEditingController companyNameController;
  late TextEditingController companyDescriptionController;


  late TextEditingController contactFirstNameController;
  late TextEditingController contactLastNameController;
  late TextEditingController contactNinController;
  late TextEditingController contactDesignationController;
  late TextEditingController contactPhoneController;
  late TextEditingController contactEmailController;

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


  final companyDescriptionValidator = MultiValidator([
    MaxLengthValidator(500, errorText: 'descrition too long'),
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

  //
  // Future<void> _selectDateOfBirth(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: myDateOfBirth.value,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //
  //   if (picked != null) {
  //     myDateOfBirth(picked);
  //     individualDateOfBirthController.text =
  //     '${myDateOfBirth.value.day}/${myDateOfBirth.value.month}/${myDateOfBirth
  //         .value.year}';
  //   }
  // }

  final TenantController tenantController = Get.put(TenantController());

  @override
  void initState() {
    // TODO: implement initState
    _image = File('');
    tenantController.getCompanyTenantContactProfile(widget.tenantModel.id);
    tenantController.getCompanyTenantBusinessDetails(widget.tenantModel.id);
    tenantController.getCompanyTenantCountryDetails(widget.tenantModel.id);

    super.initState();
    companyNameController =
        TextEditingController(text: widget.tenantModel.name);
    companyDescriptionController =
        TextEditingController(text: widget.tenantModel.description);

    contactFirstNameController =
        TextEditingController();
    contactLastNameController =
        TextEditingController();
    contactNinController =
        TextEditingController();
    contactEmailController =
        TextEditingController();
    contactDesignationController =
        TextEditingController();
    contactPhoneController =
        TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

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
        title: 'assets/auth/logo.png',
        isTitleCentred: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Update Tenant-${widget.tenantModel.id}',

                style: AppTheme.appTitle5,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '',
                    style: AppTheme.subTextBold1,
                  )),

              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Obx(() {
                        return CustomUpdateApiGenericDropdown<BusinessTypeModel>(
                          hintText: tenantController.uCompanyBusinessType.value,
                          menuItems: tenantController.businessList.value,
                          onChanged: (value) {
                            tenantController.setBusinessTypeId(value!.id);
                          },
                        );
                      }),

                      SizedBox(height: 1.h,),

                      Obx(() {
                        return CustomUpdateApiNationalityDropdown(
                          hintText: tenantController.uCompanyCountryType.value,
                          menuItems: tenantController.nationalityList.value,
                          onChanged: (value) {
                            tenantController.setNationalityId(value!.id);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),

              SlideInUp(
                child: Container(
                  child: Form(
                    key: _companyFormKey,
                    child: Column(
                      children: [
                        Text('Company Details', style: AppTheme.appTitle3,),

                        // AppTextField(
                        //   controller: companyNameController,
                        //   hintText: 'Business Name',
                        //   obscureText: false,
                        //   keyBoardType: TextInputType.text,
                        //   validator: companyNameValidator,
                        // ),

                        AuthTextField(
                            controller: companyNameController,
                            hintText: 'Business Name',
                            obscureText: false,
                        ),

                        SizedBox(height: 1.h,),

                        AuthTextField(
                          controller: companyDescriptionController,
                          hintText: 'Description',
                          obscureText: false,
                        ),


                        // Obx(() {
                        //   return tenantController.tenantTypeId.value == 1
                        //       ? Container()
                        //       : tenantController.tenantTypeId.value == 2
                        //       ? CheckboxListTile(
                        //     value: tenantController.isAddContactPerson.value,
                        //     onChanged: (value) {
                        //       tenantController.addContactPerson(value!);
                        //     },
                        //     activeColor: AppTheme.primaryColor,
                        //     title: tenantController.isAddContactPerson.value
                        //         ? Text(
                        //       'remove Contact Person',
                        //       style: AppTheme.subTextBold1,
                        //     )
                        //         : Text(
                        //       'add Contact Person',
                        //       style: AppTheme.subTextBold1,
                        //     ),
                        //   )
                        //       : Container();
                        // }),
                        //

                      ],
                    ),
                  ),
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


              Obx(() {
                return tenantController.isContactDetailsLoading.value
                    ? Center(child: CircularProgressIndicator(),)
                    : Column(
                      children: [
                        Center(child: Text('Contact', style: AppTheme.appTitle3,)),
                        UpdateTenantProfileContactForm(
                  tenantController: tenantController,
                  contactKey: _contactFormKey,
                  // contactFirstNameController: contactFirstNameController,
                  // contactLastNameController: contactLastNameController,
                  // contactNinController: contactNinController,
                  // contactDesignationController: contactDesignationController,
                  // contactPhoneController: contactPhoneController,
                  // contactEmailController: contactEmailController,
                  designationValidator: contactDesignationValidator,
                  emailValidator: contactEmailValidator,
                  firstNameValidator: contactFirstNameValidator,
                  lastNameValidator: contactLastNameValidator,
                  ninValidator: contactNinValidator,
                  phoneValidator: contactPhoneValidator,

                ),
                      ],
                    );
              }),

              SizedBox(
                height: 2.h,
              ),

              AppButton(
                title: 'Submit',
                color: AppTheme.primaryColor,
                function: () async {

                  if (_formKey.currentState!.validate() &&
                      _companyFormKey.currentState!.validate() &&
                      _contactFormKey.currentState!.validate()) {
                    // Get.snackbar(
                    //     'Posting Company', 'With Company Contact');

                    await tenantController.updateCompanyTenantDetailsWithContact(
                      companyNameController.text.trim().toString(),
                      12,
                      tenantController.businessTypeId.value,
                        "userStorage.read('userProfileId')",
                      tenantController.nationalityId.value,
                      contactFirstNameController.text.trim().toString(),
                      contactLastNameController.text.trim().toString(),
                      contactNinController.text.trim().toString(),
                      contactDesignationController.text.trim().toString(),
                      contactPhoneController.text.trim().toString(),
                      contactEmailController.text.trim().toString(),
                      companyDescriptionController.text.toString(),
                    );


                  } else {
                    Fluttertoast.showToast(msg: 'Fill in fields');
                  }

                },
              ),

              SizedBox(
                height: 2.h,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
