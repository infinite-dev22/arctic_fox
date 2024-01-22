// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
// import 'package:smart_rent/controllers/property_options/property_options_controller.dart';
// import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
// import 'package:smart_rent/controllers/units/unit_controller.dart';
// import 'package:smart_rent/models/property/property_model.dart';
// import 'package:smart_rent/screens/property/floor_tab_screen.dart';
// import 'package:smart_rent/screens/property/payment_tab_screen.dart';
// import 'package:smart_rent/screens/property/property_details_tab.dart';
// import 'package:smart_rent/screens/property/property_tab_options_widget.dart';
// import 'package:smart_rent/screens/property/room_tab_screen.dart';
// import 'package:smart_rent/screens/property/tenant_tab_screen.dart';
// import 'package:smart_rent/screens/property/video_player_screen.dart';
// import 'package:smart_rent/styles/app_theme.dart';
// import 'package:smart_rent/widgets/property_details_widget.dart';
// import 'package:smart_rent/widgets/property_options_widget.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class PropertyDetailsScreen extends StatefulWidget {
//   final TenantController tenantController;
//   final UnitController unitController;
//   final PropertyModel propertyModel;
//   const PropertyDetailsScreen({super.key, required this.unitController, required this.tenantController, required this.propertyModel});
//
//   @override
//   State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
// }
//
// class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> with TickerProviderStateMixin{
//
//
//   String videoId = YoutubePlayer.convertUrlToId("https://youtu.be/izFcWmL1YYQ")
//       .toString();
//   // final PropertyOptionsController propertyOptionsController = Get.put(
//   //     PropertyOptionsController());
//   final PropertyDetailsOptionsController propertyDetailsOptionsController = Get.put(PropertyDetailsOptionsController());
//   // final UnitController unitController = Get.put(UnitController(), permanent: true);
//   @override
//   void initState() {
//     // TODO: implement initState
//     print(videoId);
//     super.initState();
//     widget.unitController.fetchAllFloors(widget.propertyModel.id!);
//     widget.tenantController.fetchOnlyAvailableUnits(widget.propertyModel.id!);
//     widget.unitController.listenToUnitChanges(widget.propertyModel.id!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // TabController propertyTabCont = TabController(length: 4, vsync: this);
//
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         backgroundColor: AppTheme.whiteColor,
//         // backgroundColor: Colors.white,
//         extendBodyBehindAppBar: true,
//             body: NestedScrollView(
//             body: Padding(
//               padding: EdgeInsets.only(left: 5.w, right: 5.w),
//               child: SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 7.5.h,),
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height,
//                                   child: TabBarView(
//                                     // controller: propertyTabCont,
//                                     children: [
//                                       PropertyDetailsTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController, propertyModel: widget.propertyModel,),
//                                       // FloorTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController,),
//                                       RoomTabScreen(
//                                           unitController: widget.unitController,
//                                           propertyDetailsOptionsController: propertyDetailsOptionsController,
//                                            propertyModel: widget.propertyModel
//                                       ),
//                                       TenantTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController,),
//                                       PaymentTabScreen(
//                                         propertyDetailsOptionsController: propertyDetailsOptionsController,
//                                         unitController: widget.unitController,
//                                           propertyModel: widget.propertyModel
//
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                   ],
//                 ),
//               ),
//             ),
//
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverOverlapAbsorber(
//                 handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//                 sliver: SliverAppBar(
//                   floating: false,
//                   pinned: true,
//                   snap: false,
//                   forceElevated: innerBoxIsScrolled,
//                   automaticallyImplyLeading: false,
//                   // toolbarHeight: 50.h,
//                   // flexibleSpace: FlexibleSpaceBar(
//                   //   background: Column(
//                   //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //     children: [
//                   //       Stack(
//                   //         children: [
//                   //                 CarouselSlider.builder(
//                   //                   itemCount: 1,
//                   //                   options: CarouselOptions(
//                   //                     aspectRatio: 1 / 1,
//                   //                     viewportFraction: 1,
//                   //                     autoPlay: true,
//                   //                     height: 40.h,
//                   //                     onPageChanged: (index, r) {
//                   //                       // setState(() {
//                   //                       //   currentIndex = index;
//                   //                       // });
//                   //                       // print(currentIndex);
//                   //                     },
//                   //                   ),
//                   //                   itemBuilder: (context, index, real) {
//                   //                     return GestureDetector(
//                   //                       onTap: () {},
//                   //                       child: Hero(
//                   //                         tag: '',
//                   //                         child: GestureDetector(
//                   //                           onTap: () {
//                   //                             Get.to(() =>
//                   //                                 PhotoViewGallery.builder(
//                   //                                   // pageController: widget.pageController,
//                   //                                   itemCount: 1,
//                   //                                   builder: (context, index) {
//                   //                                     return PhotoViewGalleryPageOptions(
//                   //                                       imageProvider: CachedNetworkImageProvider(widget.propertyModel.documents!.fileUrl.toString()),
//                   //                                     );
//                   //                                   },
//                   //                                 ));
//                   //                             print('tapped');
//                   //                           },
//                   //                           child: CachedNetworkImage(
//                   //                             imageUrl: widget.propertyModel.documents!.fileUrl.toString(),
//                   //                             width: MediaQuery
//                   //                                 .of(context)
//                   //                                 .size
//                   //                                 .width,
//                   //                             fit: BoxFit.cover,
//                   //                             errorWidget: (context, url, error) {
//                   //                               return Container(
//                   //                                 child: Center(
//                   //                                   child: Image.asset('assets/auth/icon.png'),
//                   //                                 ),
//                   //                               );
//                   //                             },
//                   //                             // placeholder: (context, url,){
//                   //                             //   return Shimmer.fromColors(
//                   //                             //     baseColor: Colors.grey.shade200,
//                   //                             //     highlightColor: AppTheme.primaryLightColor,
//                   //                             //     child: Container(
//                   //                             //       height: 50.h,
//                   //                             //       width: MediaQuery.of(context).size.width,
//                   //                             //       color: Colors.grey.shade200,
//                   //                             //     ),
//                   //                             //   );
//                   //                             // },
//                   //                           ),
//                   //                         ),
//                   //                       ),
//                   //                     );
//                   //                   },
//                   //                 ),
//                   //
//                   //                 Positioned(
//                   //                   top: 7.5.h,
//                   //                   left: 5.w,
//                   //                   child: GestureDetector(
//                   //                     onTap: () {
//                   //                       Get.back();
//                   //                     },
//                   //                     child: CircleAvatar(
//                   //                       radius: 6.w,
//                   //                       backgroundColor: Colors.white,
//                   //                       child: Image.asset('assets/general/arrow-left.png'),
//                   //                     ),
//                   //                   ),
//                   //                 ),
//                   //
//                   //                 Positioned(
//                   //                   top: 7.5.h,
//                   //                   right: 5.w,
//                   //                   child: Bounceable(
//                   //                     onTap: () {
//                   //
//                   //                     },
//                   //                     child: CircleAvatar(
//                   //                       radius: 6.w,
//                   //                       backgroundColor: Colors.white,
//                   //                       child: Image.asset('assets/general/share.png'),
//                   //                     ),
//                   //                   ),
//                   //                 ),
//                   //
//                   //                 Positioned(
//                   //                   bottom: 2.h,
//                   //                   right: 5.w,
//                   //                   child: Container(
//                   //                     padding: EdgeInsets.symmetric(
//                   //                         horizontal: 5.w, vertical: 1.h),
//                   //                     decoration: BoxDecoration(
//                   //                         color: Colors.white,
//                   //                         borderRadius: BorderRadius.circular(20.sp),
//                   //                         shape: BoxShape.rectangle
//                   //                     ),
//                   //                     child: Text('1/1', style: AppTheme.descriptionText1,),
//                   //                   ),
//                   //                 ),
//                   //
//                   //               ],
//                   //             ),
//                   //
//                   //       // Padding(
//                   //       //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                   //       //   child: Column(
//                   //       //     mainAxisAlignment: MainAxisAlignment.start,
//                   //       //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //       //     children: [
//                   //       //       Text('Imperial Mall', style: AppTheme.appTitle1,),
//                   //       //
//                   //       //       Row(
//                   //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       //         children: [
//                   //       //           PropertyDetailsWidget(detail: 'Entebbe, Uganda',
//                   //       //             icon: 'assets/general/location.png',),
//                   //       //           PropertyDetailsWidget(
//                   //       //             detail: '40 units', icon: 'assets/property/bed.png',),
//                   //       //         ],
//                   //       //       ),
//                   //       //
//                   //       //       Row(
//                   //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       //         children: [
//                   //       //           PropertyDetailsWidget(
//                   //       //             detail: 'Available - 15unites (35%)',),
//                   //       //           PropertyDetailsWidget(
//                   //       //             detail: '673', icon: 'assets/property/size.png',),
//                   //       //         ],
//                   //       //       ),
//                   //       //     ],
//                   //       //   ),
//                   //       // )
//                   //
//                   //     ],
//                   //   ), // Your custom widget goes here
//                   // ),
//                   // expandedHeight: 50.h,
//                   bottom: PreferredSize(
//                     preferredSize: Size.fromHeight(2.5.h),
//                     child: TabBar(
//
//                       tabs: [
//                         Tab(icon: Icon(Icons.meeting_room_rounded), child: Text('Details', style: AppTheme.subTextBold2,)),
//                         Tab(icon: Icon(Icons.bed), child: Text('Units', style: AppTheme.subTextBold2,)),
//                         Tab(icon: Icon(Icons.person), child: Text('Tenants', style: AppTheme.subTextBold2,)),
//                         Tab(icon: Icon(Icons.payment), child: Text('Payments', style: AppTheme.subTextBold2,)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//         ),
//
//         // body: SingleChildScrollView(
//         //   physics: BouncingScrollPhysics(),
//         //   child: Column(
//         //     mainAxisAlignment: MainAxisAlignment.start,
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: [
//         //       Stack(
//         //         children: [
//         //           CarouselSlider.builder(
//         //             itemCount: 1,
//         //             options: CarouselOptions(
//         //               aspectRatio: 1 / 1,
//         //               viewportFraction: 1,
//         //               autoPlay: true,
//         //               height: 50.h,
//         //               onPageChanged: (index, r) {
//         //                 // setState(() {
//         //                 //   currentIndex = index;
//         //                 // });
//         //                 // print(currentIndex);
//         //               },
//         //             ),
//         //             itemBuilder: (context, index, real) {
//         //               return GestureDetector(
//         //                 onTap: () {},
//         //                 child: Hero(
//         //                   tag: '',
//         //                   child: GestureDetector(
//         //                     onTap: () {
//         //                       Get.to(() =>
//         //                           PhotoViewGallery.builder(
//         //                             // pageController: widget.pageController,
//         //                             itemCount: 1,
//         //                             builder: (context, index) {
//         //                               return PhotoViewGalleryPageOptions(
//         //                                 imageProvider: CachedNetworkImageProvider(
//         //                                     'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg'),
//         //                               );
//         //                             },
//         //                           ));
//         //                       print('tapped');
//         //                     },
//         //                     child: CachedNetworkImage(
//         //                       imageUrl: 'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg',
//         //                       width: MediaQuery
//         //                           .of(context)
//         //                           .size
//         //                           .width,
//         //                       fit: BoxFit.cover,
//         //                       errorWidget: (context, url, error) {
//         //                         return Container(
//         //                           child: Center(
//         //                             child: Image.network(
//         //                                 'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg'),
//         //                           ),
//         //                         );
//         //                       },
//         //                       // placeholder: (context, url,){
//         //                       //   return Shimmer.fromColors(
//         //                       //     baseColor: Colors.grey.shade200,
//         //                       //     highlightColor: AppTheme.primaryLightColor,
//         //                       //     child: Container(
//         //                       //       height: 50.h,
//         //                       //       width: MediaQuery.of(context).size.width,
//         //                       //       color: Colors.grey.shade200,
//         //                       //     ),
//         //                       //   );
//         //                       // },
//         //                     ),
//         //                   ),
//         //                 ),
//         //               );
//         //             },
//         //           ),
//         //
//         //           Positioned(
//         //             top: 5.h,
//         //             left: 5.w,
//         //             child: GestureDetector(
//         //               onTap: () {
//         //                 Get.back();
//         //               },
//         //               child: CircleAvatar(
//         //                 backgroundColor: Colors.white,
//         //                 child: Image.asset('assets/general/arrow-left.png'),
//         //               ),
//         //             ),
//         //           ),
//         //
//         //           Positioned(
//         //             top: 5.h,
//         //             right: 5.w,
//         //             child: Bounceable(
//         //               onTap: () {
//         //
//         //               },
//         //               child: CircleAvatar(
//         //                 backgroundColor: Colors.white,
//         //                 child: Image.asset('assets/general/share.png'),
//         //               ),
//         //             ),
//         //           ),
//         //
//         //           Positioned(
//         //             bottom: 2.h,
//         //             right: 5.w,
//         //             child: Container(
//         //               padding: EdgeInsets.symmetric(
//         //                   horizontal: 5.w, vertical: 1.h),
//         //               decoration: BoxDecoration(
//         //                   color: Colors.white,
//         //                   borderRadius: BorderRadius.circular(20.sp),
//         //                   shape: BoxShape.rectangle
//         //               ),
//         //               child: Text('1/1', style: AppTheme.descriptionText1,),
//         //             ),
//         //           ),
//         //
//         //         ],
//         //       ),
//         //
//         //       // SizedBox(height: 2.h,),
//         //
//         //       Padding(
//         //         padding: EdgeInsets.only(left: 5.w, right: 5.w),
//         //         child: Column(
//         //           crossAxisAlignment: CrossAxisAlignment.start,
//         //           children: [
//         //             // Center(
//         //             //   child: Bounceable(
//         //             //     onTap: () {
//         //             //       YoutubePlayerController _controller = YoutubePlayerController(
//         //             //         initialVideoId: videoId,
//         //             //         flags: YoutubePlayerFlags(
//         //             //           autoPlay: true,
//         //             //           mute: true,
//         //             //         ),
//         //             //       );
//         //             //       Get.to(() =>
//         //             //           VideoPlayerScreen(controller: _controller));
//         //             //     },
//         //             //     child: Container(
//         //             //       width: 90.w,
//         //             //       height: 6.h,
//         //             //       decoration: BoxDecoration(
//         //             //           borderRadius: BorderRadius.circular(20.sp),
//         //             //           color: Colors.deepPurpleAccent.withOpacity(0.1),
//         //             //           border: Border.all(
//         //             //               color: AppTheme.purpleColor1,
//         //             //               width: 2
//         //             //           )
//         //             //       ),
//         //             //       child: Center(
//         //             //         child: Text('Watch video',
//         //             //           style: AppTheme.purpleText1,),
//         //             //       ),
//         //             //     ),
//         //             //   ),
//         //             // ),
//         //
//         //             SizedBox(height: 2.h,),
//         //
//         //             Text('Imperial Mall', style: AppTheme.appTitle1,),
//         //
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //               children: [
//         //                 PropertyDetailsWidget(detail: 'Entebbe, Uganda',
//         //                   icon: 'assets/general/location.png',),
//         //                 PropertyDetailsWidget(
//         //                   detail: '40 rooms', icon: 'assets/property/bed.png',),
//         //               ],
//         //             ),
//         //
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //               children: [
//         //                 PropertyDetailsWidget(
//         //                   detail: 'Available - 15unites (35%)',),
//         //                 PropertyDetailsWidget(
//         //                   detail: '673', icon: 'assets/property/size.png',),
//         //               ],
//         //             ),
//         //
//         //             TabBar(
//         //               // controller: calcTabCont,
//         //               tabs: [
//         //                 Tab(icon: Icon(Icons.meeting_room_rounded), text: 'Floors'),
//         //                 Tab(icon: Icon(Icons.bed), text: 'Rooms'),
//         //                 Tab(icon: Icon(Icons.person), text: 'Tenants'),
//         //                 Tab(icon: Icon(Icons.payment), text: 'Payments'),
//         //               ],
//         //             ),
//         //
//         //             // Container(
//         //             //   height: 5.h,
//         //             //   alignment: Alignment.center,
//         //             //   child: TabBar(
//         //             //       labelPadding: EdgeInsets.only( right: 0.w, left: 0.w),
//         //             //       labelStyle: AppTheme.subTextBold,
//         //             //       isScrollable: false,
//         //             //       labelColor: AppTheme.primaryColor,
//         //             //       unselectedLabelColor: AppTheme.greyTextColor1,
//         //             //       controller: propertyTabCont,
//         //             //       indicatorColor: Colors.transparent,
//         //             //       indicator: BoxDecoration(
//         //             //           color: Colors.black,
//         //             //           borderRadius: BorderRadius.circular(15.sp)
//         //             //       ),
//         //             //
//         //             //       tabs:  [
//         //             //         Tab(text: 'Floors'),
//         //             //         Tab(text: 'Rooms'),
//         //             //         Tab(text: 'Tenants'),
//         //             //         Tab(text: 'Payments'),
//         //             //       ]),
//         //             // ),
//         //
//         //             SizedBox(
//         //               height: MediaQuery.of(context).size.height,
//         //               child: TabBarView(
//         //                 // controller: propertyTabCont,
//         //                 children: [
//         //                   FloorTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController,),
//         //                   RoomTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController),
//         //                   Icon(Icons.directions_car, size: 350),
//         //                   Icon(Icons.directions_car, size: 350),
//         //                 ],
//         //               ),
//         //             ),
//         //
//         //             // ListView.builder(
//         //             //   physics: NeverScrollableScrollPhysics(),
//         //             //     shrinkWrap: true,
//         //             //     itemCount: propertyDetailsOptionsController.options.length,
//         //             //     itemBuilder: (context, index) {
//         //             //       var option = propertyDetailsOptionsController.options[index];
//         //             //       return Obx(() {
//         //             //         return PropertyOptionsWidget(
//         //             //           title: option.toString(),
//         //             //           index: index,
//         //             //           selectedIndex: propertyDetailsOptionsController
//         //             //               .selectedIndex.value,
//         //             //           function: () {
//         //             //             propertyDetailsOptionsController.changeSelectedIndex(
//         //             //                 index);
//         //             //
//         //             //             if(propertyDetailsOptionsController.selectedIndex.value == 0){
//         //             //               propertyDetailsOptionsController.addFloorWidget();
//         //             //             } else {
//         //             //
//         //             //             }
//         //             //
//         //             //             // if(propertyDetailsOptionsController.selectedIndex.value == 0){
//         //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(false);
//         //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(true);
//         //             //             //   propertyDetailsOptionsController.addFloorWidget();
//         //             //             // } else if (propertyDetailsOptionsController.selectedIndex.value == 1){
//         //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(false);
//         //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(true);
//         //             //             // } else {
//         //             //             //
//         //             //             // }
//         //             //
//         //             //             print(propertyDetailsOptionsController.selectedIndex);
//         //             //             print(index);
//         //             //           },
//         //             //           propertyDetailsOptionsController: propertyDetailsOptionsController,
//         //             //           viewAllFunction: (){
//         //             //             propertyDetailsOptionsController.changeSelectedIndex(
//         //             //                 index);
//         //             //
//         //             //             // if(propertyDetailsOptionsController.selectedIndex.value == 0){
//         //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(true);
//         //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(false);
//         //             //             // } else if (propertyDetailsOptionsController.selectedIndex.value == 1){
//         //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(true);
//         //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(false);
//         //             //             //
//         //             //             // } else {
//         //             //             //
//         //             //             // }
//         //             //
//         //             //           },
//         //             //         );
//         //             //       });
//         //             //     }),
//         //
//         //
//         //
//         //           ],
//         //         ),
//         //       )
//         //
//         //     ],
//         //   ),
//         // ),
//
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/controllers/property_options/property_options_controller.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/controllers/units/unit_controller.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/screens/property/floor_tab_screen.dart';
import 'package:smart_rent/screens/property/payment_tab_screen.dart';
import 'package:smart_rent/screens/property/property_details_tab.dart';
import 'package:smart_rent/screens/property/property_tab_options_widget.dart';
import 'package:smart_rent/screens/property/room_tab_screen.dart';
import 'package:smart_rent/screens/property/tenant_tab_screen.dart';
import 'package:smart_rent/screens/property/video_player_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/property_details_widget.dart';
import 'package:smart_rent/widgets/property_options_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final TenantController tenantController;
  final UnitController unitController;
  final PropertyModel propertyModel;
  const PropertyDetailsScreen({super.key, required this.unitController, required this.tenantController, required this.propertyModel});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> with TickerProviderStateMixin{


  String videoId = YoutubePlayer.convertUrlToId("https://youtu.be/izFcWmL1YYQ")
      .toString();
  // final PropertyOptionsController propertyOptionsController = Get.put(
  //     PropertyOptionsController());
  final PropertyDetailsOptionsController propertyDetailsOptionsController = Get.put(PropertyDetailsOptionsController());
  // final UnitController unitController = Get.put(UnitController(), permanent: true);
  @override
  void initState() {
    // TODO: implement initState
    print(videoId);
    super.initState();
    widget.unitController.fetchAllFloors(widget.propertyModel.id!);
    widget.tenantController.fetchOnlyAvailableUnits(widget.propertyModel.id!);
    widget.unitController.listenToUnitChanges(widget.propertyModel.id!);
  }

  @override
  Widget build(BuildContext context) {

    // TabController propertyTabCont = TabController(length: 4, vsync: this);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppTheme.whiteColor,
        // backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          body: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 7.5.h,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      // controller: propertyTabCont,
                      children: [
                        PropertyDetailsTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController, propertyModel: widget.propertyModel,),
                        // FloorTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController,),
                        RoomTabScreen(
                            unitController: widget.unitController,
                            propertyDetailsOptionsController: propertyDetailsOptionsController,
                            propertyModel: widget.propertyModel
                        ),
                        TenantTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController, propertyModel: widget.propertyModel),
                        PaymentTabScreen(
                            propertyDetailsOptionsController: propertyDetailsOptionsController,
                            unitController: widget.unitController,
                            propertyModel: widget.propertyModel

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  forceElevated: innerBoxIsScrolled,
                  automaticallyImplyLeading: false,
                  // toolbarHeight: 50.h,
                  // flexibleSpace: FlexibleSpaceBar(
                  //   background: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Stack(
                  //         children: [
                  //                 CarouselSlider.builder(
                  //                   itemCount: 1,
                  //                   options: CarouselOptions(
                  //                     aspectRatio: 1 / 1,
                  //                     viewportFraction: 1,
                  //                     autoPlay: true,
                  //                     height: 40.h,
                  //                     onPageChanged: (index, r) {
                  //                       // setState(() {
                  //                       //   currentIndex = index;
                  //                       // });
                  //                       // print(currentIndex);
                  //                     },
                  //                   ),
                  //                   itemBuilder: (context, index, real) {
                  //                     return GestureDetector(
                  //                       onTap: () {},
                  //                       child: Hero(
                  //                         tag: '',
                  //                         child: GestureDetector(
                  //                           onTap: () {
                  //                             Get.to(() =>
                  //                                 PhotoViewGallery.builder(
                  //                                   // pageController: widget.pageController,
                  //                                   itemCount: 1,
                  //                                   builder: (context, index) {
                  //                                     return PhotoViewGalleryPageOptions(
                  //                                       imageProvider: CachedNetworkImageProvider(widget.propertyModel.documents!.fileUrl.toString()),
                  //                                     );
                  //                                   },
                  //                                 ));
                  //                             print('tapped');
                  //                           },
                  //                           child: CachedNetworkImage(
                  //                             imageUrl: widget.propertyModel.documents!.fileUrl.toString(),
                  //                             width: MediaQuery
                  //                                 .of(context)
                  //                                 .size
                  //                                 .width,
                  //                             fit: BoxFit.cover,
                  //                             errorWidget: (context, url, error) {
                  //                               return Container(
                  //                                 child: Center(
                  //                                   child: Image.asset('assets/auth/icon.png'),
                  //                                 ),
                  //                               );
                  //                             },
                  //                             // placeholder: (context, url,){
                  //                             //   return Shimmer.fromColors(
                  //                             //     baseColor: Colors.grey.shade200,
                  //                             //     highlightColor: AppTheme.primaryLightColor,
                  //                             //     child: Container(
                  //                             //       height: 50.h,
                  //                             //       width: MediaQuery.of(context).size.width,
                  //                             //       color: Colors.grey.shade200,
                  //                             //     ),
                  //                             //   );
                  //                             // },
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     );
                  //                   },
                  //                 ),
                  //
                  //                 Positioned(
                  //                   top: 7.5.h,
                  //                   left: 5.w,
                  //                   child: GestureDetector(
                  //                     onTap: () {
                  //                       Get.back();
                  //                     },
                  //                     child: CircleAvatar(
                  //                       radius: 6.w,
                  //                       backgroundColor: Colors.white,
                  //                       child: Image.asset('assets/general/arrow-left.png'),
                  //                     ),
                  //                   ),
                  //                 ),
                  //
                  //                 Positioned(
                  //                   top: 7.5.h,
                  //                   right: 5.w,
                  //                   child: Bounceable(
                  //                     onTap: () {
                  //
                  //                     },
                  //                     child: CircleAvatar(
                  //                       radius: 6.w,
                  //                       backgroundColor: Colors.white,
                  //                       child: Image.asset('assets/general/share.png'),
                  //                     ),
                  //                   ),
                  //                 ),
                  //
                  //                 Positioned(
                  //                   bottom: 2.h,
                  //                   right: 5.w,
                  //                   child: Container(
                  //                     padding: EdgeInsets.symmetric(
                  //                         horizontal: 5.w, vertical: 1.h),
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: BorderRadius.circular(20.sp),
                  //                         shape: BoxShape.rectangle
                  //                     ),
                  //                     child: Text('1/1', style: AppTheme.descriptionText1,),
                  //                   ),
                  //                 ),
                  //
                  //               ],
                  //             ),
                  //
                  //       // Padding(
                  //       //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  //       //   child: Column(
                  //       //     mainAxisAlignment: MainAxisAlignment.start,
                  //       //     crossAxisAlignment: CrossAxisAlignment.start,
                  //       //     children: [
                  //       //       Text('Imperial Mall', style: AppTheme.appTitle1,),
                  //       //
                  //       //       Row(
                  //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //         children: [
                  //       //           PropertyDetailsWidget(detail: 'Entebbe, Uganda',
                  //       //             icon: 'assets/general/location.png',),
                  //       //           PropertyDetailsWidget(
                  //       //             detail: '40 units', icon: 'assets/property/bed.png',),
                  //       //         ],
                  //       //       ),
                  //       //
                  //       //       Row(
                  //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //         children: [
                  //       //           PropertyDetailsWidget(
                  //       //             detail: 'Available - 15unites (35%)',),
                  //       //           PropertyDetailsWidget(
                  //       //             detail: '673', icon: 'assets/property/size.png',),
                  //       //         ],
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       // )
                  //
                  //     ],
                  //   ), // Your custom widget goes here
                  // ),
                  // expandedHeight: 50.h,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(2.5.h),
                    child: TabBar(

                      tabs: [
                        Tab(icon: Icon(Icons.meeting_room_rounded), child: Text('Details', style: AppTheme.subTextBold2,)),
                        Tab(icon: Icon(Icons.bed), child: Text('Units', style: AppTheme.subTextBold2,)),
                        Tab(icon: Icon(Icons.person), child: Text('Tenants', style: AppTheme.subTextBold2,)),
                        Tab(icon: Icon(Icons.payment), child: Text('Payments', style: AppTheme.subTextBold2,)),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
        ),

        // body: SingleChildScrollView(
        //   physics: BouncingScrollPhysics(),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Stack(
        //         children: [
        //           CarouselSlider.builder(
        //             itemCount: 1,
        //             options: CarouselOptions(
        //               aspectRatio: 1 / 1,
        //               viewportFraction: 1,
        //               autoPlay: true,
        //               height: 50.h,
        //               onPageChanged: (index, r) {
        //                 // setState(() {
        //                 //   currentIndex = index;
        //                 // });
        //                 // print(currentIndex);
        //               },
        //             ),
        //             itemBuilder: (context, index, real) {
        //               return GestureDetector(
        //                 onTap: () {},
        //                 child: Hero(
        //                   tag: '',
        //                   child: GestureDetector(
        //                     onTap: () {
        //                       Get.to(() =>
        //                           PhotoViewGallery.builder(
        //                             // pageController: widget.pageController,
        //                             itemCount: 1,
        //                             builder: (context, index) {
        //                               return PhotoViewGalleryPageOptions(
        //                                 imageProvider: CachedNetworkImageProvider(
        //                                     'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg'),
        //                               );
        //                             },
        //                           ));
        //                       print('tapped');
        //                     },
        //                     child: CachedNetworkImage(
        //                       imageUrl: 'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg',
        //                       width: MediaQuery
        //                           .of(context)
        //                           .size
        //                           .width,
        //                       fit: BoxFit.cover,
        //                       errorWidget: (context, url, error) {
        //                         return Container(
        //                           child: Center(
        //                             child: Image.network(
        //                                 'https://i.ibb.co/WVnBf75/view-geometric-buildings.jpg'),
        //                           ),
        //                         );
        //                       },
        //                       // placeholder: (context, url,){
        //                       //   return Shimmer.fromColors(
        //                       //     baseColor: Colors.grey.shade200,
        //                       //     highlightColor: AppTheme.primaryLightColor,
        //                       //     child: Container(
        //                       //       height: 50.h,
        //                       //       width: MediaQuery.of(context).size.width,
        //                       //       color: Colors.grey.shade200,
        //                       //     ),
        //                       //   );
        //                       // },
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //
        //           Positioned(
        //             top: 5.h,
        //             left: 5.w,
        //             child: GestureDetector(
        //               onTap: () {
        //                 Get.back();
        //               },
        //               child: CircleAvatar(
        //                 backgroundColor: Colors.white,
        //                 child: Image.asset('assets/general/arrow-left.png'),
        //               ),
        //             ),
        //           ),
        //
        //           Positioned(
        //             top: 5.h,
        //             right: 5.w,
        //             child: Bounceable(
        //               onTap: () {
        //
        //               },
        //               child: CircleAvatar(
        //                 backgroundColor: Colors.white,
        //                 child: Image.asset('assets/general/share.png'),
        //               ),
        //             ),
        //           ),
        //
        //           Positioned(
        //             bottom: 2.h,
        //             right: 5.w,
        //             child: Container(
        //               padding: EdgeInsets.symmetric(
        //                   horizontal: 5.w, vertical: 1.h),
        //               decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.circular(20.sp),
        //                   shape: BoxShape.rectangle
        //               ),
        //               child: Text('1/1', style: AppTheme.descriptionText1,),
        //             ),
        //           ),
        //
        //         ],
        //       ),
        //
        //       // SizedBox(height: 2.h,),
        //
        //       Padding(
        //         padding: EdgeInsets.only(left: 5.w, right: 5.w),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             // Center(
        //             //   child: Bounceable(
        //             //     onTap: () {
        //             //       YoutubePlayerController _controller = YoutubePlayerController(
        //             //         initialVideoId: videoId,
        //             //         flags: YoutubePlayerFlags(
        //             //           autoPlay: true,
        //             //           mute: true,
        //             //         ),
        //             //       );
        //             //       Get.to(() =>
        //             //           VideoPlayerScreen(controller: _controller));
        //             //     },
        //             //     child: Container(
        //             //       width: 90.w,
        //             //       height: 6.h,
        //             //       decoration: BoxDecoration(
        //             //           borderRadius: BorderRadius.circular(20.sp),
        //             //           color: Colors.deepPurpleAccent.withOpacity(0.1),
        //             //           border: Border.all(
        //             //               color: AppTheme.purpleColor1,
        //             //               width: 2
        //             //           )
        //             //       ),
        //             //       child: Center(
        //             //         child: Text('Watch video',
        //             //           style: AppTheme.purpleText1,),
        //             //       ),
        //             //     ),
        //             //   ),
        //             // ),
        //
        //             SizedBox(height: 2.h,),
        //
        //             Text('Imperial Mall', style: AppTheme.appTitle1,),
        //
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 PropertyDetailsWidget(detail: 'Entebbe, Uganda',
        //                   icon: 'assets/general/location.png',),
        //                 PropertyDetailsWidget(
        //                   detail: '40 rooms', icon: 'assets/property/bed.png',),
        //               ],
        //             ),
        //
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 PropertyDetailsWidget(
        //                   detail: 'Available - 15unites (35%)',),
        //                 PropertyDetailsWidget(
        //                   detail: '673', icon: 'assets/property/size.png',),
        //               ],
        //             ),
        //
        //             TabBar(
        //               // controller: calcTabCont,
        //               tabs: [
        //                 Tab(icon: Icon(Icons.meeting_room_rounded), text: 'Floors'),
        //                 Tab(icon: Icon(Icons.bed), text: 'Rooms'),
        //                 Tab(icon: Icon(Icons.person), text: 'Tenants'),
        //                 Tab(icon: Icon(Icons.payment), text: 'Payments'),
        //               ],
        //             ),
        //
        //             // Container(
        //             //   height: 5.h,
        //             //   alignment: Alignment.center,
        //             //   child: TabBar(
        //             //       labelPadding: EdgeInsets.only( right: 0.w, left: 0.w),
        //             //       labelStyle: AppTheme.subTextBold,
        //             //       isScrollable: false,
        //             //       labelColor: AppTheme.primaryColor,
        //             //       unselectedLabelColor: AppTheme.greyTextColor1,
        //             //       controller: propertyTabCont,
        //             //       indicatorColor: Colors.transparent,
        //             //       indicator: BoxDecoration(
        //             //           color: Colors.black,
        //             //           borderRadius: BorderRadius.circular(15.sp)
        //             //       ),
        //             //
        //             //       tabs:  [
        //             //         Tab(text: 'Floors'),
        //             //         Tab(text: 'Rooms'),
        //             //         Tab(text: 'Tenants'),
        //             //         Tab(text: 'Payments'),
        //             //       ]),
        //             // ),
        //
        //             SizedBox(
        //               height: MediaQuery.of(context).size.height,
        //               child: TabBarView(
        //                 // controller: propertyTabCont,
        //                 children: [
        //                   FloorTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController,),
        //                   RoomTabScreen(propertyDetailsOptionsController: propertyDetailsOptionsController),
        //                   Icon(Icons.directions_car, size: 350),
        //                   Icon(Icons.directions_car, size: 350),
        //                 ],
        //               ),
        //             ),
        //
        //             // ListView.builder(
        //             //   physics: NeverScrollableScrollPhysics(),
        //             //     shrinkWrap: true,
        //             //     itemCount: propertyDetailsOptionsController.options.length,
        //             //     itemBuilder: (context, index) {
        //             //       var option = propertyDetailsOptionsController.options[index];
        //             //       return Obx(() {
        //             //         return PropertyOptionsWidget(
        //             //           title: option.toString(),
        //             //           index: index,
        //             //           selectedIndex: propertyDetailsOptionsController
        //             //               .selectedIndex.value,
        //             //           function: () {
        //             //             propertyDetailsOptionsController.changeSelectedIndex(
        //             //                 index);
        //             //
        //             //             if(propertyDetailsOptionsController.selectedIndex.value == 0){
        //             //               propertyDetailsOptionsController.addFloorWidget();
        //             //             } else {
        //             //
        //             //             }
        //             //
        //             //             // if(propertyDetailsOptionsController.selectedIndex.value == 0){
        //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(false);
        //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(true);
        //             //             //   propertyDetailsOptionsController.addFloorWidget();
        //             //             // } else if (propertyDetailsOptionsController.selectedIndex.value == 1){
        //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(false);
        //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(true);
        //             //             // } else {
        //             //             //
        //             //             // }
        //             //
        //             //             print(propertyDetailsOptionsController.selectedIndex);
        //             //             print(index);
        //             //           },
        //             //           propertyDetailsOptionsController: propertyDetailsOptionsController,
        //             //           viewAllFunction: (){
        //             //             propertyDetailsOptionsController.changeSelectedIndex(
        //             //                 index);
        //             //
        //             //             // if(propertyDetailsOptionsController.selectedIndex.value == 0){
        //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(true);
        //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(false);
        //             //             // } else if (propertyDetailsOptionsController.selectedIndex.value == 1){
        //             //             //   propertyDetailsOptionsController.changeAddRoomStatus(true);
        //             //             //   propertyDetailsOptionsController.changeAddFloorStatus(false);
        //             //             //
        //             //             // } else {
        //             //             //
        //             //             // }
        //             //
        //             //           },
        //             //         );
        //             //       });
        //             //     }),
        //
        //
        //
        //           ],
        //         ),
        //       )
        //
        //     ],
        //   ),
        // ),

      ),
    );
  }
}
