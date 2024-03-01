import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/property_details_widget.dart';

class PropertyDetailsTabScreen extends StatelessWidget {
  final PropertyDetailsOptionsController propertyDetailsOptionsController;
  final int id;

  const PropertyDetailsTabScreen(
      {super.key,
      required this.propertyDetailsOptionsController,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyBloc, PropertyState>(
      builder: (context, state) {
        if (state.status == PropertyStatus.initial) {
          context.read<PropertyBloc>().add(LoadSinglePropertyEvent(id));
        }
        if (state.status == PropertyStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == PropertyStatus.successDetails) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6.h,
                ),
                Hero(
                  tag: '',
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => PhotoViewGallery.builder(
                            // pageController: widget.pageController,
                            itemCount: 1,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: CachedNetworkImageProvider(
                                  'https://img.freepik.com/free-photo/modern-country-houses-construction_1385-14.jpg?w=900&t=st=1708306349~exp=1708306949~hmac=204c10c13554eb7ee4a54f8e24d8a7bcf35164505c7d5ada5028393530909e5f',
                                ),
                              );
                            },
                          ));
                      print('tapped');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/free-photo/modern-country-houses-construction_1385-14.jpg?w=900&t=st=1708306349~exp=1708306949~hmac=204c10c13554eb7ee4a54f8e24d8a7bcf35164505c7d5ada5028393530909e5f',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        height: 20.h,
                        errorWidget: (context, url, error) {
                          return Container(
                            child: Center(
                              child: Image.asset('assets/auth/icon.png'),
                            ),
                          );
                        },
                        // placeholder: (context, url,){
                        //   return Shimmer.fromColors(
                        //     baseColor: Colors.grey.shade200,
                        //     highlightColor: AppTheme.primaryLightColor,
                        //     child: Container(
                        //       height: 50.h,
                        //       width: MediaQuery.of(context).size.width,
                        //       color: Colors.grey.shade200,
                        //     ),
                        //   );
                        // },
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.property!.name.toString(),
                      style: AppTheme.appTitle1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PropertyDetailsWidget(
                          detail: state.property!.location.toString(),
                          icon: 'assets/general/location.png',
                        ),
                        PropertyDetailsWidget(
                          detail: ' units',
                          icon: 'assets/property/bed.png',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PropertyDetailsWidget(
                          detail: '',
                        ),
                        PropertyDetailsWidget(
                          detail: state.property!.squareMeters.toString(),
                          icon: 'assets/property/size.png',
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        }

        if (state.status == PropertyStatus.emptyDetails) {
          return Center(
            child: Text('No Details'),
          );
        }
        if (state.status == PropertyStatus.errorDetails) {
          return Center(
            child: Text('An Error Occured'),
          );
        }

        return Container();
      },
    );
  }
}
