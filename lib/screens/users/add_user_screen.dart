import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/role/user_role_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class AddUserScreen extends StatefulWidget {
  final UserController userController;

  const AddUserScreen({
    super.key,
    required this.userController,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController firstNameEditingController =
      TextEditingController();
  final TextEditingController lastNameEditingController =
      TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      TextEditingController();
  TextEditingController mobileCont = TextEditingController();

  final countryPicker = const FlCountryCodePicker();
  late CountryCode countryCode;

  var userList = ['admin', 'manager', 'user'];

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(5, errorText: 'password must be at least 5 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'input does\'nt match email'),
  ]);

  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'first name required'),
    MinLengthValidator(2, errorText: 'first name too short'),
    MaxLengthValidator(15, errorText: 'first name too long'),
  ]);
  final lastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'last name required'),
    MinLengthValidator(2, errorText: 'last name too short'),
    MaxLengthValidator(15, errorText: 'last name too long'),
  ]);
  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'phone is required'),
    MinLengthValidator(9, errorText: 'phone number is short'),
    MaxLengthValidator(9, errorText: 'phone number has exceeded'),
  ]);

  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryCode =
        const CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppImageHeader(
        title: 'assets/auth/srw.png',
        isTitleCentred: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(height: 2.h,),
                  // Center(child: Text('Congratulations', style: AppTheme.appTitle1,)),
                  // Center(child: Text('on verifying the email belongs to you', style: AppTheme.blueSubText,)),
                  // SizedBox(height: 3.h,),
                  Text(
                    'Add User',
                    style: AppTheme.appTitle2,
                  ),

                  SizedBox(
                    height: 3.h,
                  ),

                  Obx(() {
                    return CustomApiUserRoleDropdown<UserRoleModel>(
                      hintText: 'Select Role e.g owner',
                      menuItems: userController.userRoleList.value,
                      onChanged: (value) {
                        userController.setAddedUserRoleId(value!.id!);
                      },
                    );
                  }),
                  SizedBox(
                    height: 1.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 42.5.w,
                        child: AuthTextField(
                          controller: firstNameEditingController,
                          hintText: 'Firstname',
                          obscureText: false,
                        ),
                      ),
                      SizedBox(
                        width: 42.5.w,
                        child: AuthTextField(
                          controller: lastNameEditingController,
                          hintText: 'Lastname',
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 1.h,
                  ),

                  AuthTextField(
                    isEmail: true,
                    controller: emailEditingController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  SizedBox(
                    height: 1.h,
                  ),

                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 90.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: TextFormField(
                      // maxLength: 9,
                      onChanged: (value) {
                        print(
                            'dialCode==${countryCode.dialCode} code==${countryCode.code} phone==${mobileCont.text}');
                      },
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.phone,
                      controller: mobileCont,
                      validator: phoneValidator,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Bounceable(
                            onTap: () async {
                              final code = await countryPicker.showPicker(
                                  context: context);
                              setState(() {
                                countryCode = code!;
                              });
                              print(countryCode);
                            },
                            child: SizedBox(
                              width: 30.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  countryCode.flagImage,
                                  Container(
                                    child: Text(countryCode.dialCode),
                                  ),
                                  const Icon(
                                      Icons.keyboard_arrow_down_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: AppTheme.appWidgetColor,
                        hintText: 'Enter Your Phone',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 1.h,
                  ),

                  AppPasswordTextField(
                    controller: passwordEditingController,
                    hintText: 'Password',
                    fillColor: AppTheme.appWidgetColor,
                    // validator: passwordValidator,
                  ),

                  SizedBox(
                    height: 1.h,
                  ),

                  // AppPasswordTextField(
                  //   controller: confirmPasswordEditingController,
                  //   hintText: 'Confirm Password',
                  //   validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(val.toString(), ),
                  // ),

                  SizedBox(
                    height: 3.h,
                  ),

                  // Text('TYPE OF USER', style: AppTheme.appFieldTitle,),
                  // CustomGenericDropdown<String>(
                  //     hintText: 'Choose your user-type',
                  //   menuItems: userList,
                  //   onChanged: (value){
                  //
                  //   },
                  // ),

                  AppButton(
                      title: 'Add User',
                      color: AppTheme.primaryColor,
                      function: () async {
                        if (firstNameEditingController.text.isEmpty ||
                            lastNameEditingController.text.isEmpty ||
                            emailEditingController.text.isEmpty ||
                            confirmPasswordEditingController.text.isEmpty ||
                            passwordEditingController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'fill in all fields',
                              gravity: ToastGravity.TOP);
                        } else {
                          // await userController
                          //     .adminCreateUser(
                          //         emailEditingController.text.trim().toString(),
                          //         passwordEditingController.text
                          //             .trim()
                          //             .toString(),
                          //         firstNameEditingController.text
                          //             .trim()
                          //             .toString(),
                          //         lastNameEditingController.text
                          //             .trim()
                          //             .toString(),
                          //         userController.addedUserRoleId.value,
                          //     countryCode.dialCode+mobileCont.text.trim().toString(),
                          // ).then((value) {
                          //   emailEditingController.clear();
                          //   passwordEditingController.clear();
                          //   firstNameEditingController.clear();
                          //   lastNameEditingController.clear();
                          //   confirmPasswordEditingController.clear();
                          //   userController.addedUserRoleId.value == 0;
                          //   Get.back();
                          // });
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
