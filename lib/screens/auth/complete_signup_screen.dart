import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class CompleteSignUpScreen extends StatefulWidget {
  final String businessName;
  final String description;

  const CompleteSignUpScreen(
      {super.key, required this.businessName, required this.description});

  @override
  State<CompleteSignUpScreen> createState() => _CompleteSignUpScreenState();
}

class _CompleteSignUpScreenState extends State<CompleteSignUpScreen> {
  TextEditingController mobileCont = TextEditingController();

  final String _countryCode = "+256";
  final String _mobileError = "";

  final bool _isLoading = true;

  final countryPicker = const FlCountryCodePicker();
  late CountryCode countryCode;

  final RegExp _numberRegex = RegExp(r'\d');

  final TextEditingController firstNameEditingController =
      TextEditingController();
  final TextEditingController lastNameEditingController =
      TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      TextEditingController();

  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'phone is required'),
    MinLengthValidator(9, errorText: 'phone number is short'),
    MaxLengthValidator(9, errorText: 'phone number has exceeded'),
  ]);

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'Complete Sign Up',
                    style: AppTheme.appTitle2,
                  ),
                  // Center(child: Text('we need something more', style: AppTheme.blueSubText,)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 42.5.w,
                        child: AuthTextField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          controller: firstNameEditingController,
                          hintText: 'Firstname',
                          obscureText: false,
                        ),
                      ),
                      SizedBox(
                        width: 42.5.w,
                        child: AuthTextField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
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

                  AuthTextField(
                    isEmail: true,
                    controller: emailEditingController,
                    hintText: 'Email',
                    obscureText: false,
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

                  AppPasswordTextField(
                    controller: confirmPasswordEditingController,
                    hintText: 'Confirm Password',
                    fillColor: AppTheme.appWidgetColor,
                  ),

                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return FlutterSwitch(
                          width: 100,
                          height: 50,
                          toggleSize: 40,
                          value: userController.isPhoneSelected.value,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: AppTheme.primaryColor,
                          inactiveToggleColor: AppTheme.appWidgetColor,
                          activeColor: AppTheme.primaryColor,
                          inactiveColor: AppTheme.appWidgetColor,
                          activeIcon: Icon(Icons.phone, color: Colors.white),
                          inactiveIcon: Icon(
                            Icons.email,
                          ),
                          onToggle: (val) {
                            userController.setPhoneAsUsername();
                          },
                        );
                      }),
                      Row(
                        children: [
                          Text('use '),
                          Obx(() {
                            return userController.isPhoneSelected.value == true
                                ? Text(
                                    'phone',
                                    style: AppTheme.blueSubText,
                                  )
                                : Text(
                                    'email',
                                    style: AppTheme.blackSubText,
                                  );
                          }),
                          Text(' as Username'),
                        ],
                      )
                    ],
                  ),

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

                  Obx(() {
                    return AppButton(
                        isLoading: userController.isSignUpLoading.value,
                        title: 'Submit',
                        color: AppTheme.primaryColor,
                        function: () async {
                          print(
                              'mobile length ==${countryCode.dialCode} ${mobileCont.text} is ${mobileCont.text.length}');

                          if (firstNameEditingController.text.isEmpty ||
                              lastNameEditingController.text.isEmpty ||
                              emailEditingController.text.isEmpty ||
                              passwordEditingController.text.isEmpty ||
                              confirmPasswordEditingController.text.isEmpty ||
                              mobileCont.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'fill in all fields',
                                gravity: ToastGravity.TOP);
                          } else {
                            if (mobileCont.text.length < 9) {
                              Fluttertoast.showToast(
                                  msg: 'phone number is short',
                                  gravity: ToastGravity.TOP);
                            } else if (mobileCont.text.length > 11) {
                              Fluttertoast.showToast(
                                  msg: 'phone number is long',
                                  gravity: ToastGravity.TOP);
                            } else if (firstNameEditingController.text.length <
                                3) {
                              Fluttertoast.showToast(
                                  msg: 'short first name',
                                  gravity: ToastGravity.TOP);
                            } else if (lastNameEditingController.text.length <
                                3) {
                              Fluttertoast.showToast(
                                  msg: 'short last name',
                                  gravity: ToastGravity.TOP);
                            } else if (passwordEditingController.text.length <
                                6) {
                              Fluttertoast.showToast(
                                  msg: 'short password : min is 6',
                                  gravity: ToastGravity.TOP);
                            } else if (passwordEditingController.text
                                    .toString() !=
                                confirmPasswordEditingController.text
                                    .toString()) {
                              Fluttertoast.showToast(
                                  msg: 'mismatching passwords',
                                  gravity: ToastGravity.TOP);
                            } else if (!_numberRegex.hasMatch(
                                passwordEditingController.text.toString())) {
                              Fluttertoast.showToast(
                                  msg: 'password must have a number',
                                  gravity: ToastGravity.TOP);
                            } else if (!_numberRegex.hasMatch(
                                confirmPasswordEditingController.text
                                    .toString())) {
                              Fluttertoast.showToast(
                                  msg: 'confirm password must have a number',
                                  gravity: ToastGravity.TOP);
                            } else {
                              print('EVERYTHING IS OKAY');
                              if (userController.isPhoneSelected.value ==
                                  true) {
                                print('Phone SignUp');
                                await userController
                                    .createUserWithPhone(
                                        '${countryCode.dialCode}${mobileCont.text.trim()}',
                                        passwordEditingController.text
                                            .trim()
                                            .toString(),
                                        emailEditingController.text
                                            .trim()
                                            .toString(),
                                        widget.businessName.toString(),
                                        widget.description.toString(),
                                        firstNameEditingController.text
                                            .trim()
                                            .toString(),
                                        lastNameEditingController.text
                                            .trim()
                                            .toString(),
                                        userController.isPhoneSelected.value)
                                    .then((value) {
                                  emailEditingController.clear();
                                  passwordEditingController.clear();
                                  firstNameEditingController.clear();
                                  lastNameEditingController.clear();
                                  confirmPasswordEditingController.clear();
                                  mobileCont.clear();
                                  // Get.to(() => VerifyPhoneOtpScreen(phone: '${countryCode.dialCode}${mobileCont.text.trim()}'));
                                });
                              } else {
                                print('Email SignUp');
                                await userController
                                    .createUserWithEmail(
                                        emailEditingController.text
                                            .trim()
                                            .toString(),
                                        passwordEditingController.text
                                            .trim()
                                            .toString(),
                                        widget.businessName.toString(),
                                        widget.description.toString(),
                                        firstNameEditingController.text
                                            .trim()
                                            .toString(),
                                        lastNameEditingController.text
                                            .trim()
                                            .toString(),
                                        '${countryCode.dialCode}${mobileCont.text.trim()}',
                                        userController.isPhoneSelected.value)
                                    .then((value) {
                                  emailEditingController.clear();
                                  passwordEditingController.clear();
                                  firstNameEditingController.clear();
                                  lastNameEditingController.clear();
                                  confirmPasswordEditingController.clear();
                                  mobileCont.clear();
                                });
                              }
                            }
                          }
                        });
                  }),

                  SizedBox(
                    height: 3.h,
                  ),

                  Center(
                      child: Bounceable(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            'back to login',
                            style: AppTheme.subTextBold,
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
