import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/screens/tenant/add_tenant_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_header.dart';
import 'package:smart_rent/widgets/app_image_header.dart';
import 'package:smart_rent/widgets/tenant_card_widget.dart';

class TenantListScreen extends StatefulWidget {
  const TenantListScreen({super.key});

  @override
  State<TenantListScreen> createState() => _TenantListScreenState();
}

class _TenantListScreenState extends State<TenantListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppImageHeader(
          title: 'assets/auth/logo.png',
        isTitleCentred: true,
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
                        Text('Tenants', style: AppTheme.appTitle5,),
                        Text('Manage your tenants', style: AppTheme.subText,),
                      ],
                    ),
                  ),
                  Bounceable(
                    onTap: (){
                      Get.to(() => AddTenantScreen(), transition: Transition.downToUp);
                    },
                      child: Image.asset('assets/home/add.png')),
                ],
              ),

              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 30,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: SlideInUp(child: TenantCardWidget()),
                    );
                  }),

            ],
          ),
        ),
      ),

    );
  }
}
