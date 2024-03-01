import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class UpdateTenantProfileContactForm extends StatelessWidget {
  // final TextEditingController contactFirstNameController;
  // final TextEditingController contactLastNameController;
  // final TextEditingController contactNinController;
  // final TextEditingController contactDesignationController;
  // final TextEditingController contactPhoneController;
  // final TextEditingController contactEmailController;
  final TenantController tenantController;
  final String? Function(String?)? firstNameValidator;
  final String? Function(String?)? lastNameValidator;
  final String? Function(String?)? designationValidator;
  final String? Function(String?)? ninValidator;
  final String? Function(String?)? phoneValidator;
  final String? Function(String?)? emailValidator;
  final GlobalKey<FormState> contactKey;

  const UpdateTenantProfileContactForm({
    super.key,
    // required this.contactFirstNameController,
    // required this.contactLastNameController,
    // required this.contactNinController,
    // required this.contactDesignationController,
    // required this.contactPhoneController,
    // required this.contactEmailController,
    required this.contactKey,
    this.firstNameValidator,
    this.lastNameValidator,
    this.designationValidator,
    this.ninValidator,
    this.phoneValidator,
    this.emailValidator,
    required this.tenantController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        child: FadeInUp(
          child: Form(
            key: contactKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: Obx(() {
                        return AuthTextField(
                          controller: TextEditingController(
                              text: tenantController.uCompanyFirstName.value
                                  .toString()),
                          hintText: 'First Name',
                          obscureText: false,
                          // validator: firstNameValidator,
                          keyBoardType: TextInputType.text,
                        );
                      }),
                    ),
                    Obx(() {
                      return SizedBox(
                        width: 40.w,
                        child: AuthTextField(
                          controller: TextEditingController(
                              text: tenantController.uCompanySurname.value
                                  .toString()),
                          hintText: 'Surname',
                          obscureText: false,
                          // validator: lastNameValidator,
                          keyBoardType: TextInputType.text,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() {
                  return AuthTextField(
                    controller: TextEditingController(
                        text: tenantController.uCompanyDesignation.value
                            .toString()),

                    hintText: 'Designation',
                    obscureText: false,
                    // validator: designationValidator,
                    keyBoardType: TextInputType.text,
                  );
                }),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() {
                  return AuthTextField(
                    controller: TextEditingController(
                        text: tenantController.uCompanyNin.value.toString()),
                    hintText: 'NIN',
                    obscureText: false,
                    keyBoardType: TextInputType.text,
                    // validator: ninValidator,
                  );
                }),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() {
                  return AuthTextField(
                    controller: TextEditingController(
                        text:
                            tenantController.uCompanyContact.value.toString()),
                    hintText: 'Contact',
                    obscureText: false,
                    keyBoardType: TextInputType.number,
                    // validator: phoneValidator,
                  );
                }),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() {
                  return AuthTextField(
                    controller: TextEditingController(
                        text: tenantController.uCompanyEmail.value.toString()),
                    hintText: 'Email',
                    obscureText: false,
                    keyBoardType: TextInputType.emailAddress,
                    // validator: emailValidator,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
