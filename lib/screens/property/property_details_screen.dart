import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 1,
            options: CarouselOptions(
              aspectRatio: 1/1,
              viewportFraction: 1,
              autoPlay: true,
              height: 50.h,
              onPageChanged: (index, r){
                // setState(() {
                //   currentIndex = index;
                // });
                // print(currentIndex);
              },
            ),
            itemBuilder: (context, index, real){

              return GestureDetector(
                onTap: (){
                  // Get.to(()=> MultiGallery(urlImages: widget.product.productVariant.images[index].productVariantImgUrl, index: currentIndex,));
                },
                child: Hero(
                  tag: '',
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() =>
                          PhotoViewGallery.builder(
                            // pageController: widget.pageController,
                            itemCount: 1,
                            builder: (context, index){

                              return PhotoViewGalleryPageOptions(
                                imageProvider: CachedNetworkImageProvider('assets/property/mall1.jpg'),
                              );
                            },
                          ));
                      print('tapped');
                    },
                    child: CachedNetworkImage(
                      imageUrl: '',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error){
                        return Container(
                          child: Center(
                            child: Image.asset(''),
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
              );
            },
          ),

        ],
      ),
    );
  }
}
