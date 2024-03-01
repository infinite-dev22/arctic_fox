import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/complaints/complaints_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';

class ComplaintsWidget extends StatelessWidget {
  final ComplaintsController complaintsController;

  const ComplaintsWidget({super.key, required this.complaintsController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      height: 35.h,
      width: 90.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            topRight: Radius.circular(15.sp),
            bottomLeft: Radius.circular(15.sp),
            bottomRight: Radius.circular(15.sp)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complaints',
            style: AppTheme.appTitle1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tenant',
                style: AppTheme.subText,
              ),
              Text(
                'Complaint',
                style: AppTheme.subText,
              ),
              Text(
                'Seveirity',
                style: AppTheme.subText,
              ),
            ],
          ),
          Divider(
            height: 1.h,
            color: Colors.grey,
            thickness: 2,
          ),
          Obx(() {
            return Container(
              height: 15.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: complaintsController.complaints.length,
                  itemBuilder: (context, index) {
                    var complaint = complaintsController.complaints[index];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          complaint.tenant,
                          style: AppTheme.gray70Text,
                        ),
                        Text(
                          complaint.description,
                          style: AppTheme.gray70Text2,
                        ),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: complaint.sevierity,
                        )
                      ],
                    );
                  }),
            );
          }),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int page = 1;
                    page <=
                        (complaintsController.initialComplaints.length /
                                complaintsController.complaintsPerPage)
                            .ceil();
                    page++)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Bounceable(
                      onTap: () {
                        complaintsController.goToPage(page);
                      },
                      child: Container(
                        height: 5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: AppTheme.fillColor,
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(
                              color:
                                  page == complaintsController.currentPage.value
                                      ? AppTheme.greyTextColor1
                                      : Colors.transparent,
                              width: 2,
                            )),
                        child: Center(
                          child: Text(
                            page.toString(),
                            style: AppTheme.subTextInter1,
                          ),
                        ),
                      ),
                      // child: CircleAvatar(
                      //   backgroundColor: page ==
                      //       complaintsController.currentPage.value
                      //       ? Colors.green
                      //       : null,
                      //   child: Text(page.toString()),
                      // ),
                    ),
                  )
              ],
            );
          }),
        ],
      ),
    );
  }
}
