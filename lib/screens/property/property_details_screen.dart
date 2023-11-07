import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/floor_option_controller.dart';
import 'package:smart_rent/controllers/property_options/property_options_controller.dart';
import 'package:smart_rent/screens/property/video_player_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/property_details_widget.dart';
import 'package:smart_rent/widgets/property_options_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {


  String videoId = YoutubePlayer.convertUrlToId("https://youtu.be/izFcWmL1YYQ")
      .toString();
  final PropertyOptionsController propertyOptionsController = Get.put(
      PropertyOptionsController());
  final FloorOptionsController floorOptionsController = Get.put(FloorOptionsController());

  @override
  void initState() {
    // TODO: implement initState
    print(videoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: 1,
                  options: CarouselOptions(
                    aspectRatio: 1 / 1,
                    viewportFraction: 1,
                    autoPlay: true,
                    height: 50.h,
                    onPageChanged: (index, r) {
                      // setState(() {
                      //   currentIndex = index;
                      // });
                      // print(currentIndex);
                    },
                  ),
                  itemBuilder: (context, index, real) {
                    return GestureDetector(
                      onTap: () {},
                      child: Hero(
                        tag: '',
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                PhotoViewGallery.builder(
                                  // pageController: widget.pageController,
                                  itemCount: 1,
                                  builder: (context, index) {
                                    return PhotoViewGalleryPageOptions(
                                      imageProvider: CachedNetworkImageProvider(
                                          'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg'),
                                    );
                                  },
                                ));
                            print('tapped');
                          },
                          child: CachedNetworkImage(
                            imageUrl: 'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg',
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Container(
                                child: Center(
                                  child: Image.network(
                                      'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg'),
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

                Positioned(
                  top: 5.h,
                  left: 5.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/general/arrow-left.png'),
                    ),
                  ),
                ),

                Positioned(
                  top: 5.h,
                  right: 5.w,
                  child: Bounceable(
                    onTap: () {

                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/general/share.png'),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 2.h,
                  right: 5.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w, vertical: 1.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.sp),
                        shape: BoxShape.rectangle
                    ),
                    child: Text('1/1', style: AppTheme.descriptionText1,),
                  ),
                ),

              ],
            ),

            SizedBox(height: 2.h,),

            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Bounceable(
                      onTap: () {
                        YoutubePlayerController _controller = YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: YoutubePlayerFlags(
                            autoPlay: true,
                            mute: true,
                          ),
                        );
                        Get.to(() =>
                            VideoPlayerScreen(controller: _controller));
                      },
                      child: Container(
                        width: 90.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.deepPurpleAccent.withOpacity(0.1),
                            border: Border.all(
                                color: AppTheme.purpleColor1,
                                width: 2
                            )
                        ),
                        child: Center(
                          child: Text('Watch video',
                            style: AppTheme.purpleText1,),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h,),

                  Text('Imperial Mall', style: AppTheme.appTitle1,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PropertyDetailsWidget(detail: 'Entebbe, Uganda',
                        icon: 'assets/general/location.png',),
                      PropertyDetailsWidget(
                        detail: '40 rooms', icon: 'assets/property/bed.png',),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PropertyDetailsWidget(
                        detail: 'Available - 15unites (35%)',),
                      PropertyDetailsWidget(
                        detail: '673', icon: 'assets/property/size.png',),
                    ],
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: propertyOptionsController.options.length,
                      itemBuilder: (context, index) {
                        var option = propertyOptionsController.options[index];
                        return Obx(() {
                          return PropertyOptionsWidget(
                            title: option.toString(),
                            index: index,
                            selectedIndex: propertyOptionsController
                                .selectedIndex.value,
                            function: () {
                              propertyOptionsController.changeSelectedIndex(
                                  index);

                              if(propertyOptionsController.selectedIndex.value == 0){
                                floorOptionsController.addWidget();
                              } else {

                              }

                              print(propertyOptionsController.selectedIndex);
                              print(index);
                            },
                            floorOptionsController: floorOptionsController,
                          );
                        });
                      }),

                  // PropertyOptionsWidget(title: 'Floors',),
                  // PropertyOptionsWidget(title: 'Rooms', ),
                  // PropertyOptionsWidget(title: 'Tenants', ),
                  // PropertyOptionsWidget(title: 'Paymenets',),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
