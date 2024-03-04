import 'package:flutter/material.dart';
import 'package:smart_rent/styles/app_theme.dart';

class OccupancyWidget extends StatelessWidget {
  const OccupancyWidget({super.key});

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

    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, constraints),
            const Divider(
              color: AppTheme.inActiveColor,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      child: Column(
        children: [
          Row(
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
              const Text("Units: 28 of 39"),
            ],
          ),
          DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: AppTheme.darker,
                    tabs: [
                      Tab(
                        child: Text(
                          "Occupied",
                          style: TextStyle(
                            color: AppTheme.darker,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Available",
                          style: TextStyle(
                            color: AppTheme.darker,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: constraints.minWidth,
                    height: constraints.maxHeight,
                    child: const TabBarView(
                      children: [
                        DataTable1(),
                        DataTable1(),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class DataTable2 extends StatelessWidget {
  const DataTable2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            label: Text("Date"),
          ),
          DataColumn(
            label: Text("Name"),
          ),
          DataColumn(
            label: Text("Paid"),
          ),
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(
                Text("20/02/2024"),
              ),
              DataCell(
                Text("Alison Kyrill"),
              ),
              DataCell(
                Text("USD 1,500"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("28/01/2024"),
              ),
              DataCell(
                Text("Mac'Migel Hanis"),
              ),
              DataCell(
                Text("USD 850"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("01/02/2024"),
              ),
              DataCell(
                Text("Mitch WinStone"),
              ),
              DataCell(
                Text("USD 1,000"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("03/03/2024"),
              ),
              DataCell(
                Text("Abdul Krimlin"),
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
}

class DataTable1 extends StatelessWidget {
  const DataTable1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            label: Text("Date"),
          ),
          DataColumn(
            label: Text("Name"),
          ),
          DataColumn(
            label: Text("Paid"),
          ),
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(
                Text("20/02/2024"),
              ),
              DataCell(
                Text("Alison Kyrill"),
              ),
              DataCell(
                Text("USD 1,500"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("28/01/2024"),
              ),
              DataCell(
                Text("Mac'Migel Hanis"),
              ),
              DataCell(
                Text("USD 850"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("01/02/2024"),
              ),
              DataCell(
                Text("Mitch WinStone"),
              ),
              DataCell(
                Text("USD 1,000"),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text("03/03/2024"),
              ),
              DataCell(
                Text("Abdul Krimlin"),
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
}
