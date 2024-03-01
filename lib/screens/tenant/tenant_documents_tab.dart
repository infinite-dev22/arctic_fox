import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';

class TenantDocumentsTab extends StatelessWidget {
  final TenantController tenantController;

  const TenantDocumentsTab({super.key, required this.tenantController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${tenantController.specificTenantDocumentList.length.toString()} ${tenantController.specificTenantDocumentList.length == 1 ? 'file' : 'files'}',
            style: AppTheme.blueSubText,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.purple
                  ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 1.h,
                  crossAxisSpacing: 1.w,
                  children: List.generate(
                      tenantController.specificTenantDocumentList.length,
                      (index) {
                    var doc =
                        tenantController.specificTenantDocumentList[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                // 'https://img.freepik.com/free-vector/engraving-hand-drawn-golden-wedding-invitation-template_23-2149021171.jpg?w=740&t=st=1705229939~exp=1705230539~hmac=5aa81c5642161b975756f3467d303b0b9364eeb2cf9d68d56965519fcc3f3176',
                                doc.fileUrl.toString()),
                            fit: BoxFit.cover,
                          )),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
