import 'package:animate_do/animate_do.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:owesome_validator/owesome_validator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/role/user_role_model.dart';
import 'package:smart_rent/screens/tenant/add_tenant_screen.dart';
import 'package:smart_rent/screens/tenant/update_company_tenant_with%20contact_screen.dart';
import 'package:smart_rent/screens/tenant/update_individual_tenant_screen.dart';
import 'package:smart_rent/screens/users/add_user_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/app_loader.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/tenant_card_widget.dart';
import 'package:smart_rent/widgets/user_card_widget.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({
    super.key,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final UserController userController =
  Get.put(UserController(), permanent: true);

  final _key = GlobalKey<ExpandableFabState>();

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

  final RegExp _numberRegex = RegExp(r'\d');

  void showAddUserBottomSheet(BuildContext context) async {
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
        builder: (context, state) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return WillPopScope(
                  onWillPop: () async {
                    firstNameEditingController.clear();
                    lastNameEditingController.clear();
                    emailEditingController.clear();
                    passwordEditingController.clear();
                    confirmPasswordEditingController.clear();
                    mobileCont.clear();
                    // propertyPic = File('');
                    return true;
                  },
                  child: Material(
                    color: AppTheme.whiteColor,
                    child: Column(
                      children: [
                        Material(
                          elevation: 1,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 7.5.h,
                            decoration: BoxDecoration(boxShadow: []),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 2.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Bounceable(
                                      onTap: () {
                                        firstNameEditingController.clear();
                                        lastNameEditingController.clear();
                                        emailEditingController.clear();
                                        passwordEditingController.clear();
                                        confirmPasswordEditingController
                                            .clear();
                                        mobileCont.clear();
                                        // propertyPic = File('');

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
                                    'Add User',
                                    style: AppTheme.darkBlueTitle2,
                                  ),
                                  Obx(() {
                                    return userController.isCreateAdminLoading.value ?
                                    AppLoader(color: AppTheme.primaryColor,) :
                                    Bounceable(
                                        onTap: () async {
                                          if (firstNameEditingController
                                              .text.isEmpty ||
                                              lastNameEditingController
                                                  .text.isEmpty ||
                                              emailEditingController.text
                                                  .isEmpty ||
                                              passwordEditingController
                                                  .text.isEmpty ||
                                              confirmPasswordEditingController
                                                  .text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: 'fill in all fields',
                                                gravity: ToastGravity.TOP);
                                          } else {
                                            if (mobileCont.text.length < 9) {
                                              Fluttertoast.showToast(
                                                  msg: 'phone number is short',
                                                  gravity: ToastGravity.TOP);
                                            } else
                                            if (mobileCont.text.length > 11) {
                                              Fluttertoast.showToast(
                                                  msg: 'phone number is long',
                                                  gravity: ToastGravity.TOP);
                                            } else
                                            if (firstNameEditingController
                                                .text.length <
                                                3) {
                                              Fluttertoast.showToast(
                                                  msg: 'short first name',
                                                  gravity: ToastGravity.TOP);
                                            } else if (lastNameEditingController
                                                .text.length <
                                                3) {
                                              Fluttertoast.showToast(
                                                  msg: 'short last name',
                                                  gravity: ToastGravity.TOP);
                                            } else if (passwordEditingController
                                                .text.length <
                                                6) {
                                              Fluttertoast.showToast(
                                                  msg: 'short password : min is 6',
                                                  gravity: ToastGravity.TOP);
                                            } else if (userController
                                                .addedUserRoleId.value ==
                                                0) {
                                              Fluttertoast.showToast(
                                                  msg: 'add role',
                                                  gravity: ToastGravity.TOP);
                                            } else
                                            if (passwordEditingController.text
                                                .toString() !=
                                                confirmPasswordEditingController
                                                    .text
                                                    .toString()) {
                                              Fluttertoast.showToast(
                                                  msg: 'mismatching passwords',
                                                  gravity: ToastGravity.TOP);
                                            } else if (!_numberRegex.hasMatch(
                                                passwordEditingController.text
                                                    .toString())) {
                                              Fluttertoast.showToast(
                                                  msg: 'password must have a number',
                                                  gravity: ToastGravity.TOP);
                                            } else if (!_numberRegex.hasMatch(
                                                confirmPasswordEditingController
                                                    .text
                                                    .toString())) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  'confirm password must have a number',
                                                  gravity: ToastGravity.TOP);
                                            } else {
                                              await userController
                                                  .adminCreateUser(
                                                emailEditingController.text
                                                    .trim()
                                                    .toString(),
                                                passwordEditingController.text
                                                    .trim()
                                                    .toString(),
                                                firstNameEditingController.text
                                                    .trim()
                                                    .toString(),
                                                lastNameEditingController.text
                                                    .trim()
                                                    .toString(),
                                                userController.addedUserRoleId
                                                    .value,
                                                countryCode.dialCode +
                                                    mobileCont.text.trim()
                                                        .toString(),
                                              )
                                                  .then((value) {
                                                emailEditingController.clear();
                                                passwordEditingController
                                                    .clear();
                                                firstNameEditingController
                                                    .clear();
                                                lastNameEditingController
                                                    .clear();
                                                userController
                                                    .addedUserRoleId.value ==
                                                    0;
                                                Get.back();
                                              });
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 17.5.sp,
                                          ),
                                        ));
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return CustomApiUserRoleDropdown<
                                      UserRoleModel>(
                                    hintText: 'Select Role e.g owner',
                                    menuItems: userController.userRoleList
                                        .value,
                                    onChanged: (value) {
                                      userController.setAddedUserRoleId(
                                          value!.id!);
                                    },
                                  );
                                }),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
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
                                      borderRadius: BorderRadius.circular(
                                          15.sp)),
                                  child: TextFormField(
                                    // maxLength: 9,
                                    onChanged: (value) {
                                      print(
                                          'dialCode==${countryCode
                                              .dialCode} code==${countryCode
                                              .code} phone==${mobileCont
                                              .text}');
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
                                            final code = await countryPicker
                                                .showPicker(context: context);
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
                                                  child: Text(countryCode
                                                      .dialCode),
                                                ),
                                                const Icon(Icons
                                                    .keyboard_arrow_down_outlined),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: AppTheme.appBgColor,
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
                                  fillColor: AppTheme.appBgColor,
                                  // validator: passwordValidator,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                AppPasswordTextField(
                                  controller: confirmPasswordEditingController,
                                  hintText: 'Confirm Password',
                                  fillColor: AppTheme.appBgColor,
                                  // validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(val.toString(), ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      );
    });

    print(result); // This is the result.
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.listenToAllUsersInSpecificOrganizationChanges();
    countryCode =
    const CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppImageHeader(
        title: 'assets/auth/logo.png',
        isTitleCentred: true,
        leading: Container(),
      ),
      floatingActionButtonLocation:
      userStorage.read('roleId') == 4 ? null : ExpandableFab.location,
      floatingActionButton: userStorage.read('roleId') == 4
          ? Container()
          : ExpandableFab(
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
        children: [],
        onOpen: () {
          final state = _key.currentState;
          if (state != null) {
            debugPrint('isOpen:${state.isOpen}');
            state.toggle();
          }
          showAddUserBottomSheet(context);
          // Get.to(() => AddPropertyScreen(),
          //     transition: Transition.downToUp);
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
                          'Users',
                          style: AppTheme.appTitle5,
                        ),
                        Text(
                          'Manage your users',
                          style: AppTheme.subText,
                        ),
                      ],
                    ),
                  ),
                  // userStorage.read('roleId') == 4 ? Container() : Bounceable(
                  //   onTap: () {
                  //     Get.to(() => AddUserScreen(userController: userController,),
                  //         transition: Transition.downToUp);
                  //   },
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
              Obx(() {
                return userController.isUserListLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userController.userProfileModelList.length,
                    itemBuilder: (context, index) {
                      var user = userController.userProfileModelList[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: SlideInUp(
                            child: UserCardWidget(
                              userProfileModel: user,
                              userController: userController,
                              index: index,
                              deleteFunction: () {
                                userController
                                    .deleteUser(user.userId.toString());
                              },
                              editFunction: () {
                                // if(  tenant.tenantTypeId == 2){
                                //   Get.to(() => UpdateCompanyTenantWithContactScreen(tenantModel: tenant));
                                // } else {
                                //   Get.to(() => UpdateIndividualTenantScreen(tenantModel: tenant));
                                // }
                              },
                            )),
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
