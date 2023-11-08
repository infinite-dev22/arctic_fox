import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/property_options/property_details_options_controller.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_textfield.dart';
import 'package:smart_rent/widgets/room_option_widget.dart';

class PropertyOptionsWidget extends StatefulWidget {
  final String title;
  final bool isClicked;
  final int index;
  final int selectedIndex;
  final VoidCallback function;
  final VoidCallback viewAllFunction;
  final PropertyDetailsOptionsController propertyDetailsOptionsController;

  const PropertyOptionsWidget(
      {super.key, required this.title, this.isClicked = false, required this.index, required this.selectedIndex, required this.function, required this.propertyDetailsOptionsController, required this.viewAllFunction});

  @override
  State<PropertyOptionsWidget> createState() => _PropertyOptionsWidgetState();
}

class _PropertyOptionsWidgetState extends State<PropertyOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 1.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title, style: AppTheme.darkBlueText1,),
              SizedBox(width: 5.w,),
              Bounceable(
                  onTap: widget.viewAllFunction,
                  child: Image.asset('assets/general/vall5.png', width: 4.w)),
              SizedBox(width: 5.w,),
              // Bounceable(
              //     onTap: widget.function,
              //     child: Image.asset(widget.selectedIndex == widget.index
              //         ? 'assets/general/green_add.png'
              //         : 'assets/home/add.png', width: 5.w)),
            ],
          ),
          SizedBox(height: 2.h,),
          Divider(
            height: 2,
            color: AppTheme.greyTextColor1,
          ),

          Visibility(
              visible: widget.selectedIndex == widget.index,
              child: widget.selectedIndex == 0 ?
              Obx(() {
                return Column(
                  children: [
                    Bounceable(
                        onTap: widget.function,
                        child: Image.asset(widget.selectedIndex == widget.index
                            ? 'assets/general/green_add.png'
                            : 'assets/home/add.png', width: 5.w)),
                    ListView.builder(
                        padding: EdgeInsets.only(top: 2.h),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.propertyDetailsOptionsController
                            .floorDataList
                            .length,
                        itemBuilder: (context, index) {
                          var floorData = widget
                              .propertyDetailsOptionsController
                              .floorDataList[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  child: AppTextField(
                                      controller: floorData.textController,
                                      hintText: 'Floor Name',
                                      obscureText: false),
                                  width: 70.w,
                                ),
                                Bounceable(
                                  child: Image.asset(
                                      'assets/general/delete.png'),
                                  onTap: () {
                                    widget.propertyDetailsOptionsController
                                        .removeFloorWidget(
                                        index);
                                  },
                                ),

                              ],
                            ),
                          );
                        }),
                    widget.propertyDetailsOptionsController.floorDataList
                        .isEmpty
                        ? Container()
                        : Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: AppButton(title: 'Submit',
                          color: AppTheme.primaryColor,
                          function: () {}),
                        ),
                  ],
                );
              })
                  : widget.selectedIndex == 1
                  ? ListView.builder(
                itemCount: widget.propertyDetailsOptionsController.roomList.length,
                shrinkWrap: true,
                  itemBuilder: (context, index){
                  var roomModel = widget.propertyDetailsOptionsController.roomList[index];
                  return RoomOptionWidget(roomModel: roomModel);
              })
                  : widget.selectedIndex == 2 ? Text('Add Tenants')
                  : Text('Add Payments'),
            ),

          // widget.isClicked == true ? Text('Fields Open') : Container(),
        ],
      ),
    );
  }
}
