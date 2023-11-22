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
import 'package:smart_rent/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_max_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/tenant_profile_contact_form.dart';

class AddTenantScreen extends StatefulWidget {
  const AddTenantScreen({super.key});

  @override
  State<AddTenantScreen> createState() => _AddTenantScreenState();
}

class _AddTenantScreenState extends State<AddTenantScreen> {
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

  final iSalutationValidator = RequiredValidator(
      errorText: 'salutation required');

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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: myDateOfBirth.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      myDateOfBirth(picked);
      individualDateOfBirthController.text =
      '${myDateOfBirth.value.day}/${myDateOfBirth.value.month}/${myDateOfBirth
          .value.year}';
    }
  }

  final TenantController tenantController = Get.put(TenantController());

  @override
  void initState() {
    // TODO: implement initState
    _image = File('');
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
                'Add Tenant',
                style: AppTheme.appTitle5,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '#000484',
                    style: AppTheme.subTextBold1,
                  )),

              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Obx(() {
                        return CustomApiTenantTypeDropdown(
                          hintText: 'Select Tenant Type',
                          menuItems: tenantController.tenantTypeList.value,
                          onChanged: (value) {
                            tenantController.setTenantTypeId(value!.id);
                          },
                        );
                      }),


                      Obx(() {
                        return tenantController.tenantTypeId.value == 0
                            ? Container()
                            : CustomApiGenericDropdown<BusinessTypeModel>(
                          hintText: "Business Type",
                          menuItems: tenantController.businessList.value,
                          onChanged: (value) {
                            tenantController.setBusinessTypeId(value!.id);
                          },
                        );
                      }),

                      Obx(() {
                        return tenantController.tenantTypeId.value == 0
                            ? Container()
                            : CustomApiNationalityDropdown(
                          hintText: 'Country',
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

              Obx(() {
                return tenantController.tenantTypeId.value == 1
                    ? SlideInUp(
                  child: Container(
                    child: Form(
                      key: _individualFormKey,
                      child: Column(
                        children: [
                          Text('Personal Details', style: AppTheme.appTitle3,),
                          Obx(() {
                            return CustomApiGenericDropdown<
                                SalutationModel>(
                              hintText: 'Mr',
                              menuItems:
                              tenantController.salutationList.value,
                              onChanged: (value) {},
                              height: 6.5.h,
                            );
                          }),

                          SizedBox(height: 1.h,),

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 42.5.w,
                                child: AppTextField(
                                  controller: firstNameController,
                                  hintText: 'First Name',
                                  obscureText: false,
                                  keyBoardType: TextInputType.text,
                                  validator: iFirstNameValidator,
                                ),
                              ),
                              SizedBox(
                                width: 42.5.w,
                                child: AppTextField(
                                  controller: surnameNameController,
                                  hintText: 'Surname',
                                  obscureText: false,
                                  keyBoardType: TextInputType.text,
                                  validator: iLastNameValidator,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 1.h,),

                          AppTextField(
                            controller: individualEmailNameController,
                            hintText: 'Email',
                            obscureText: false,
                            keyBoardType: TextInputType.emailAddress,
                            validator: iEmailValidator,
                          ),

                          SizedBox(height: 1.h,),

                          AppTextField(
                            controller: individualPhoneNameController,
                            hintText: 'Contact',
                            obscureText: false,
                            keyBoardType: TextInputType.number,
                            validator: iPhoneValidator,
                          ),

                          SizedBox(height: 1.h,),

                          AppTextField(
                            controller: individualDateOfBirthController,
                            hintText: 'D.O.B',
                            obscureText: false,
                            onTap: (){
                              _selectDateOfBirth(context);
                            },
                          ),

                          SizedBox(height: 1.h,),

                          AppTextField(
                            controller: individualNinController,
                            hintText: 'NIN',
                            obscureText: false,
                            keyBoardType: TextInputType.text,
                            validator: iNinValidator,
                          ),

                          SizedBox(height: 1.h,),

                          Obx(() {
                            return CustomGenericDropdown<String>(
                              hintText: 'Gender',
                              menuItems: tenantController.genderList.value,
                              onChanged: (value){
                                tenantController.setNewGender(value.toString());
                              },

                            );
                          }),

                          SizedBox(height: 1.h,),

                          AppTextField(
                            controller: individualDescriptionController,
                            hintText: 'Description',
                            obscureText: false,
                            keyBoardType: TextInputType.text,
                            validator: iDescriptionValidator,
                            maxLines: 6,
                            minLines: 3,
                          ),

                        ],
                      ),
                    ),
                  ),
                )
                    : Container();
              }),


              Obx(() {
                return tenantController.tenantTypeId.value == 2
                    ? SlideInUp(
                  child: Container(
                    child: Form(
                      key: _companyFormKey,
                      child: Column(
                        children: [
                          Text('Company Details', style: AppTheme.appTitle3,),

                          AppTextField(
                            controller: companyNameController,
                            hintText: 'Business Name',
                            obscureText: false,
                            keyBoardType: TextInputType.text,
                            validator: companyNameValidator,
                          ),

                          SizedBox(height: 1.h,),

                          AppTextField(
                            controller: companyDescriptionController,
                            hintText: 'Description',
                            obscureText: false,
                            keyBoardType: TextInputType.text,
                            validator: companyDescriptionValidator,
                            maxLines: 6,
                            // maxLength: 500,
                            minLines: 3,
                          ),

                          Obx(() {
                            return tenantController.tenantTypeId.value == 1
                                ? Container()
                                : tenantController.tenantTypeId.value == 2
                                ? CheckboxListTile(
                              value: tenantController.isAddContactPerson.value,
                              onChanged: (value) {
                                tenantController.addContactPerson(value!);
                              },
                              activeColor: AppTheme.primaryColor,
                              title: tenantController.isAddContactPerson.value
                                  ? Text(
                                'remove Contact Person',
                                style: AppTheme.subTextBold1,
                              )
                                  : Text(
                                'add Contact Person',
                                style: AppTheme.subTextBold1,
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
                return tenantController.isAddContactPerson.value &&
                    tenantController.tenantTypeId.value == 2
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

              SizedBox(
                height: 2.h,
              ),

              AppButton(
                title: 'Submit',
                color: AppTheme.primaryColor,
                function: () async{

                  if (tenantController.tenantTypeId.value == 0) {
                    Fluttertoast.showToast(msg: 'Select Tenant Type');
                  } else {
                    if (tenantController.tenantTypeId.value == 1) {
                      if (_formKey.currentState!.validate() && _individualFormKey.currentState!.validate()) {
                        // Get.snackbar(
                        //     'Posting Individual', 'Adding Individual Tenant');

                        await tenantController.addPersonalTenant(
                            "${firstNameController.text
                                .trim()} ${surnameNameController.text.trim()}",
                            12,
                            tenantController.tenantTypeId.value,
                            tenantController.businessTypeId.value,
                            "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                            tenantController.nationalityId.value,
                            individualNinController.text.toString(),
                            individualPhoneNameController.text.toString(),
                            individualEmailNameController.text.toString(),
                            individualDescriptionController.text.toString(),
                            myDateOfBirth.value.toString(),
                            tenantController.newGender.value,
                        );

                        Get.back();

                        // tenantController.addIndividualTenant(
                        //   "${firstNameController.text
                        //       .trim()} ${surnameNameController.text.trim()}",
                        //   12,
                        //   tenantController.tenantTypeId.value,
                        //   "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                        //   tenantController.nationalityId.value,
                        // );
                      } else {
                        Fluttertoast.showToast(msg: 'Fill required fields');
                      }
                    } else {
                      if(tenantController.isAddContactPerson.isFalse){

                        if (_formKey.currentState!.validate() &&
                            _companyFormKey.currentState!.validate()) {
                          // Get.snackbar(
                          //     'Posting Company', 'No Company Contact');
                          await tenantController.addCompanyTenantWithoutContact(
                              companyNameController.text.toString(),
                              12,
                              tenantController.tenantTypeId.value,
                            tenantController.businessTypeId.value,
                              "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                              tenantController.nationalityId.value,
                            companyDescriptionController.text.toString(),
                          );

                          Get.back();

                        } else {
                          Fluttertoast.showToast(msg: 'Fill in fields');
                        }

                      } else {
                        if (_formKey.currentState!.validate() &&
                            _companyFormKey.currentState!.validate() && _contactFormKey.currentState!.validate()) {
                          // Get.snackbar(
                          //     'Posting Company', 'With Company Contact');
                          await tenantController.addCompanyTenantWithContact(
                              companyNameController.text.toString(),
                              12,
                              tenantController.tenantTypeId.value,
                            tenantController.businessTypeId.value,
                              "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                              tenantController.nationalityId.value,
                              contactFirstNameController.text.trim().toString(),
                            contactLastNameController.text.trim().toString(),
                            contactNinController.text.trim().toString(),
                            contactDesignationController.text.trim().toString(),
                            contactPhoneController.text.trim().toString(),
                            contactEmailController.text.trim().toString(),
                            companyDescriptionController.text.toString(),
                          );

                          Get.back();

                        } else {
                          Fluttertoast.showToast(msg: 'Fill in fields');
                        }
                      }

                    }
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
