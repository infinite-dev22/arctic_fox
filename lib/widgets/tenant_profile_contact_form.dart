import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class TenantProfileContactForm extends StatelessWidget {
  final TextEditingController contactFirstNameController;
  final TextEditingController contactLastNameController;
  final TextEditingController contactNinController;
  final TextEditingController contactDesignationController;
  final TextEditingController contactPhoneController;
  final TextEditingController contactEmailController;
  final String? Function(String?)? firstNameValidator;
  final String? Function(String?)? lastNameValidator;
  final String? Function(String?)? designationValidator;
  final String? Function(String?)? ninValidator;
  final String? Function(String?)? phoneValidator;
  final String? Function(String?)? emailValidator;
  final GlobalKey<FormState> contactKey;
  const TenantProfileContactForm({super.key,
    required this.contactFirstNameController,
    required this.contactLastNameController,
    required this.contactNinController,
    required this.contactDesignationController,
    required this.contactPhoneController,
    required this.contactEmailController,
    required this.contactKey, this.firstNameValidator, this.lastNameValidator, this.designationValidator, this.ninValidator, this.phoneValidator, this.emailValidator,
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
                      child: AppTextField(
                        controller: contactFirstNameController,
                        hintText: 'First Name',
                        obscureText: false,
                        validator: firstNameValidator,
                        keyBoardType: TextInputType.text,
                      ),
                    ),

                    SizedBox(
                      width: 40.w,
                      child: AppTextField(
                        controller: contactLastNameController,
                        hintText: 'Surname',
                        obscureText: false,
                        validator: lastNameValidator,
                        keyBoardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),

                AppTextField(
                  controller: contactDesignationController,
                  hintText: 'Designation',
                  obscureText: false,
                  validator: designationValidator,
                  keyBoardType: TextInputType.text,
                ),

                AppTextField(
                  controller: contactNinController,
                  hintText: 'NIN',
                  obscureText: false,
                  keyBoardType: TextInputType.text,
                  validator: ninValidator,

                ),

                AppTextField(
                  controller: contactPhoneController,
                  hintText: 'Contact',
                  obscureText: false,
                  keyBoardType: TextInputType.number,
                  validator: phoneValidator,
                ),

                AppTextField(
                  controller: contactEmailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyBoardType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
