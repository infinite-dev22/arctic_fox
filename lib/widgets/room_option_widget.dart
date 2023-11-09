import 'package:flutter/material.dart';
import 'package:smart_rent/models/property/room_model.dart';


class RoomOptionWidget extends StatefulWidget {
  final RoomModel roomModel;
  const RoomOptionWidget({super.key, required this.roomModel});

  @override
  State<RoomOptionWidget> createState() => _RoomOptionWidgetState();
}

class _RoomOptionWidgetState extends State<RoomOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Unit ${widget.roomModel.roomNumber}'),
      subtitle: Text('Level ${widget.roomModel.level}'),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.roomModel.amount.toString()),
          Text(widget.roomModel.status.toString()),
        ],
      ),
    );
  }
}
