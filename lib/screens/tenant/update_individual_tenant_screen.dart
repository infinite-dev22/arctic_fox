import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class UpdateIndividualTenantScreen extends StatefulWidget {
  final TenantModel tenantModel;

  const UpdateIndividualTenantScreen({super.key, required this.tenantModel});

  @override
  State<UpdateIndividualTenantScreen> createState() =>
      _UpdateIndividualTenantScreenState();
}

class _UpdateIndividualTenantScreenState
    extends State<UpdateIndividualTenantScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController surnameNameController = TextEditingController();
  final TextEditingController otherNameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyDescriptionController =
      TextEditingController();

  late TextEditingController? individualNameController;
  late TextEditingController individualEmailNameController;
  late TextEditingController individualPhoneNameController;
  late TextEditingController individualDateOfBirthController;
  late TextEditingController individualNinController;
  late TextEditingController individualDescriptionController;
  late TextEditingController individualGenderController;

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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: myDateOfBirth.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      myDateOfBirth(picked);
      individualDateOfBirthController.text =
          '${myDateOfBirth.value.day}/${myDateOfBirth.value.month}/${myDateOfBirth.value.year}';
    }
  }

  final TenantController tenantController = Get.put(TenantController());

  @override
  void initState() {
    // TODO: implement initState
    _image = File('');
    super.initState();
    tenantController.getIndividualTenantBusinessDetails(widget.tenantModel.id);
    tenantController.getIndividualTenantCountryDetails(widget.tenantModel.id);
    tenantController.getIndividualTenantProfile(widget.tenantModel.id);
    individualDescriptionController = TextEditingController(
        text: tenantController.uIndividualDescription.value.toString());
    individualDateOfBirthController = TextEditingController(
        text: tenantController.uIndividualDateOfBirth.value.toString());
    individualEmailNameController = TextEditingController(
        text: tenantController.uIndividualEmail.value.toString());
    individualPhoneNameController = TextEditingController(
        text: tenantController.uIndividualContact.value.toString());
    individualNinController = TextEditingController(
        text: tenantController.uIndividualNin.value.toString());
    individualNameController = TextEditingController(
        text: tenantController.uIndividualName.value.toString());
    individualGenderController = TextEditingController(
        text: tenantController.uIndividualGender.value.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    surnameNameController.dispose();
    otherNameController.dispose();
    phoneNoController.dispose();
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
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Update',
                overflow: TextOverflow.ellipsis,
                style: AppTheme.blueAppTitle,
              ),
              Text(
                '${widget.tenantModel.name}'.capitalizeFirst.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.appTitle5,
              ),

              // Align(
              //     alignment: Alignment.centerRight,
              //     child: Text(
              //       '#000484',
              //       style: AppTheme.subTextBold1,
              //     )),

              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Obx(() {
                        return CustomUpdateApiGenericDropdown<
                            BusinessTypeModel>(
                          hintText:
                              tenantController.uIndividualBusinessType.value,
                          menuItems: tenantController.businessList.value,
                          onChanged: (value) {
                            tenantController.setBusinessTypeId(value!.id!);
                          },
                        );
                      }),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(() {
                        return CustomUpdateApiNationalityDropdown(
                          hintText:
                              tenantController.uIndividualCountryType.value,
                          menuItems: tenantController.nationalityList.value,
                          onChanged: (value) {
                            tenantController.setNationalityId(value!.id!);
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
                    key: _individualFormKey,
                    child: Column(
                      children: [
                        Text(
                          'Personal Details',
                          style: AppTheme.appTitle3,
                        ),
                        Obx(() {
                          return CustomApiGenericDropdown<SalutationModel>(
                            hintText: 'Mr',
                            menuItems: tenantController.salutationList.value,
                            onChanged: (value) {},
                            height: 6.5.h,
                          );
                        }),

                        SizedBox(
                          height: 1.h,
                        ),

                        // Row(
                        //   mainAxisAlignment:
                        //   MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       width: 42.5.w,
                        //       child: AppTextField(
                        //         controller: firstNameController,
                        //         hintText: 'First Name',
                        //         obscureText: false,
                        //         keyBoardType: TextInputType.text,
                        //         validator: iFirstNameValidator,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 42.5.w,
                        //       child: AppTextField(
                        //         controller: surnameNameController,
                        //         hintText: 'Surname',
                        //         obscureText: false,
                        //         keyBoardType: TextInputType.text,
                        //         validator: iLastNameValidator,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // Obx(() {
                        //   return AppTextField(
                        //     controller: individualNameController ??
                        //         TextEditingController(
                        //           text: tenantController.uIndividualName.value
                        //               .toString(),
                        //         ),
                        //     hintText: 'Name',
                        //     obscureText: false,
                        //     keyBoardType: TextInputType.text,
                        //     validator: iLastNameValidator,
                        //   );
                        // }),

                        AuthTextField(
                          controller: individualNameController ??
                              TextEditingController(
                                text: tenantController.uIndividualName.value
                                    .toString(),
                              ),
                          hintText: 'Name',
                          obscureText: false,
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        // Obx(() {
                        //   return AppTextField(
                        //     controller: TextEditingController(
                        //         text: tenantController.uIndividualEmail.value
                        //             .toString()),
                        //     hintText: 'Email',
                        //     obscureText: false,
                        //     keyBoardType: TextInputType.emailAddress,
                        //     validator: iEmailValidator,
                        //   );
                        // }),

                        Obx(() {
                          return AuthTextField(
                            controller: TextEditingController(
                                text: tenantController.uIndividualEmail.value
                                    .toString()),
                            hintText: 'Email',
                            obscureText: false,
                          );
                        }),

                        SizedBox(
                          height: 1.h,
                        ),

                        Obx(() {
                          return AuthTextField(
                            controller: TextEditingController(
                                text: tenantController.uIndividualContact.value
                                    .toString()),
                            hintText: 'Contact',
                            obscureText: false,
                          );
                        }),

                        SizedBox(
                          height: 1.h,
                        ),

                        Obx(() {
                          return AuthTextField(
                            controller: TextEditingController(
                                text: tenantController
                                    .uIndividualDateOfBirth.value
                                    .toString()),
                            hintText: 'D.O.B',
                            obscureText: false,
                            onTap: () {
                              _selectDateOfBirth(context);
                            },
                          );
                        }),

                        SizedBox(
                          height: 1.h,
                        ),

                        Obx(() {
                          return AuthTextField(
                            controller: TextEditingController(
                                text: tenantController.uIndividualNin.value
                                    .toString()),
                            hintText: 'NIN',
                            obscureText: false,
                          );
                        }),

                        SizedBox(
                          height: 1.h,
                        ),

                        Obx(() {
                          return CustomGenericDropdown<String>(
                            hintText: tenantController.uIndividualGender.value
                                .toString(),
                            menuItems: tenantController.genderList.value,
                            onChanged: (value) {
                              tenantController.setNewGender(value.toString());
                            },
                          );
                        }),

                        SizedBox(
                          height: 1.h,
                        ),

                        Obx(() {
                          return DescriptionTextField(
                            controller: TextEditingController(
                                text: tenantController
                                    .uIndividualDescription.value
                                    .toString()),
                            hintText: 'Description',
                            obscureText: false,
                          );
                        }),
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

              SizedBox(
                height: 2.h,
              ),

              AppButton(
                title: 'Submit',
                color: AppTheme.primaryColor,
                function: () async {
                  print('MY name controller == $individualNameController');
                  print(
                      'MY name api == ${tenantController.uIndividualName.value}');

                  // if (_formKey.currentState!.validate() &&
                  //     _companyFormKey.currentState!.validate() &&
                  //     _contactFormKey.currentState!.validate()) {
                  //   tenantController.updatePersonalTenantDetails(
                  //       individualTenantId,
                  //       businessTypeId,
                  //       name,
                  //       nationId,
                  //       description,
                  //       tenantNo,
                  //       nin,
                  //       phone,
                  //       tenantController.,
                  //       tenantController.newGender.value,
                  //     tenantController.uIndividualDateOfBirth.value,
                  //   );
                  //
                  // } else {
                  //   Fluttertoast.showToast(msg: 'Fill in fields');
                  // }
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
