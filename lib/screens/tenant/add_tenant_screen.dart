import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
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


  final TextEditingController contactFirstNameController = TextEditingController();
  final TextEditingController contactLastNameController = TextEditingController();
  final TextEditingController contactNinController = TextEditingController();
  final TextEditingController contactDesignationController = TextEditingController();
  final TextEditingController contactPhoneController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final _contactFormKey = GlobalKey<FormState>();

  var typeList = [
    'Individual',
    'Company',
    'Family',
  ];

  var sexList = [
    'Mr',
    'Mrs',
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Add Tenant', style: AppTheme.appTitle5,),
                Align(alignment: Alignment.centerRight,
                    child: Text('#000484', style: AppTheme.subTextBold1,)),


                Obx(() {
                  return CustomApiTenantTypeDropdown(
                    hintText: 'Individual',
                    menuItems: tenantController.tenantTypeList.value,
                    onChanged: (value) {
                      tenantController.setTenantTypeId(value!.id);
                    },
                  );
                }),

                // Obx(() {
                //   return tenantController.tenantTypeId.value == 1 ? Text(
                //       'Individual') : tenantController.tenantTypeId.value == 2
                //       ? Text('Company')
                //       : Container();
                // }),


                Obx(() {
                  return tenantController.tenantTypeId.value == 1 ? Container()
                      :  tenantController.tenantTypeId.value == 2 ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: tenantController.isAddContactPerson.value,
                        onChanged: (value) {
                          tenantController.addContactPerson(value!);
                        },
                        activeColor: AppTheme.primaryColor,
                      ),

                      tenantController.isAddContactPerson.value
                          ? Text(
                        'remove Contact Person', style: AppTheme.subTextBold2,)
                          : Text(
                        'add Contact Person', style: AppTheme.subTextBold2,)
                    ],
                  ) : Container();
                }),


                Obx(() {
                  return tenantController.isAddContactPerson.value
                  && tenantController.tenantTypeId.value == 2
                      ? TenantProfileContactForm(
                    contactKey: _contactFormKey,
                    contactFirstNameController: contactFirstNameController,
                    contactLastNameController: contactLastNameController,
                    contactNinController: contactNinController,
                    contactDesignationController: contactDesignationController,
                    contactPhoneController: contactPhoneController,
                    contactEmailController: contactEmailController,
                  ) : Container();
                }),

                Obx(() {
                  return tenantController.isAddContactPerson.value ? SizedBox(
                    height: 1.h,) : Container();
                }),


                Obx(() {
                  return CustomApiGenericDropdown<BusinessTypeModel>(
                    hintText: "Business Type",
                    menuItems: tenantController.businessList.value,
                    onChanged: (value) {
                      tenantController.setBusinessTypeId(value!.id);
                    },
                  );
                }),

                Obx(() {
                  return CustomApiGenericDropdown<SalutationModel>(
                    hintText: 'Mr',
                    menuItems: tenantController.salutationList.value,
                    onChanged: (value) {

                    },
                  );
                }),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      width: 42.5.w,
                      child: AppTextField(
                        controller: firstNameController,
                        hintText: 'First Name',
                        obscureText: false,
                      ),
                    ),

                    SizedBox(
                      width: 42.5.w,
                      child: AppTextField(
                        controller: surnameNameController,
                        hintText: 'Surname',
                        obscureText: false,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 2.h,),

                Obx(() {
                  return CustomApiNationalityDropdown(
                    hintText: 'Uganda',
                    menuItems: tenantController.nationalityList.value,
                    onChanged: (value) {
                      tenantController.setNationalityId(value!.id);
                    },
                  );
                }),


                SizedBox(height: 2.h,),

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

                SizedBox(height: 3.h,),

                AppButton(
                  title: 'Submit',
                  color: AppTheme.primaryColor,
                  function: () {

                    if(tenantController.isAddContactPerson.isFalse && tenantController.tenantId.value == 1){
                      if (_formKey.currentState!.validate()) {

                        Get.snackbar('Posting Individual', 'Adding Individual Tenant');
                        // tenantController.addIndividualTenant(
                        //   "${firstNameController.text
                        //       .trim()} ${surnameNameController.text.trim()}",
                        //   12,
                        //   tenantController.tenantTypeId.value,
                        //   "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                        //   tenantController.nationalityId.value,
                        // );
                      } else {

                      }
                    } else {

                      if (_formKey.currentState!.validate() && _contactFormKey.currentState!.validate()) {


                        // tenantController.addCompanyTenant(
                        //     "${firstNameController.text
                        //         .trim()} ${surnameNameController.text.trim()}",
                        //     12,
                        //     tenantController.tenantTypeId.value,
                        //   tenantController.businessTypeId.value,
                        //     "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
                        //     tenantController.nationalityId.value,
                        //     contactFirstNameController.text.trim().toString(),
                        //   contactLastNameController.text.trim().toString(),
                        //   contactNinController.text.trim().toString(),
                        //   contactDesignationController.text.trim().toString(),
                        //   phoneNoController.text.trim().toString(),
                        //   contactEmailController.text.trim().toString(),
                        // );

                      } else {

                      }

                    }


                  },
                ),


              ],
            ),
          ),
        ),
      ),

    );
  }
}
