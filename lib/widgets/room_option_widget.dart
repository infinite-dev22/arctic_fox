import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_rent/models/property/room_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';


class RoomOptionWidget extends StatefulWidget {
  final RoomModel roomModel;
  final int index;
  const RoomOptionWidget({super.key, required this.roomModel, required this.index});

  @override
  State<RoomOptionWidget> createState() => _RoomOptionWidgetState();
}

class _RoomOptionWidgetState extends State<RoomOptionWidget> {

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(widget.index.toString(), style: AppTheme.subTextBold),
        ),
        title: Text('Unit ${widget.roomModel.roomNumber}', style: AppTheme.subTextBold,),
        subtitle: Text('Level ${widget.roomModel.level}', style: AppTheme.subText,),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${amountFormatter.format(widget.roomModel.amount.toString())}/=', style: AppTheme.appTitle3),
            Text(widget.roomModel.status.toString(), style: TextStyle(
              color: widget.roomModel.status.toString() == 'available' ? Colors.green : Colors.red,
            ),),
          ],
        ),
      ),
    );
  }
}
