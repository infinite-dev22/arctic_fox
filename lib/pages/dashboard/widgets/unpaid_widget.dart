import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';

class UnpaidWidget extends StatelessWidget {
  const UnpaidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    // final List<String> items = [
    //   'Today',
    //   'Yesterday',
    //   'Last week',
    //   'Month',
    //   '3 Month',
    //   'Custom',
    // ];
    // String? selectedValue;

    return Column(
      children: [
        _buildHeader(context),
        const Divider(
          color: AppTheme.inActiveColor,
        ),
        _buildDataTable(),
      ],
    );
  }

  Widget _buildDataTable() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.inActiveColor.withOpacity(.2),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text("Tenant"),
          ),
          DataColumn(
            label: Text("Period"),
          ),
          DataColumn(
            label: Text("Amount"),
          ),
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(
                Text("Alison Kyrill"),
              ),
              DataCell(
                Text("20/02/2024"),
              ),
              DataCell(
                Text("USD 1,500"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("Mac'Migel Hanis"),
              ),
              DataCell(
                Text("28/01/2024"),
              ),
              DataCell(
                Text("USD 850"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("Mitch WinStone"),
              ),
              DataCell(
                Text("01/02/2024"),
              ),
              DataCell(
                Text("USD 1,000"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("Abdul Krimlin"),
              ),
              DataCell(
                Text("03/03/2024"),
              ),
              DataCell(
                Text("USD 2,560"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: () {},
            child: const Text("Filter"),
          ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton2<String>(
          //     isExpanded: true,
          //     hint: Text(
          //       'Select period',
          //       style: TextStyle(
          //         fontSize: 14,
          //         color: Theme.of(context).hintColor,
          //       ),
          //     ),
          //     items: items
          //         .map((String item) => DropdownMenuItem<String>(
          //               value: item,
          //               child: Text(
          //                 item,
          //                 style: const TextStyle(
          //                   fontSize: 14,
          //                 ),
          //               ),
          //             ))
          //         .toList(),
          //     value: selectedValue,
          //     onChanged: (String? value) {
          //       // TODO: Add state management here later.
          //     },
          //     buttonStyleData: const ButtonStyleData(
          //       padding: EdgeInsets.symmetric(horizontal: 16),
          //       height: 40,
          //       width: 140,
          //     ),
          //     menuItemStyleData: const MenuItemStyleData(
          //       height: 40,
          //     ),
          //   ),
          // ),
          const Text("Total: USD 5,910"),
        ],
      ),
    );
  }
}
