import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/pages/property/bloc/property_bloc.dart';
import 'package:smart_rent/screens/test/bloc/country_city_bloc.dart';
import 'package:smart_rent/styles/app_theme.dart';

class CountryCityListScreenLayout extends StatefulWidget {
  const CountryCityListScreenLayout({Key? key}) : super(key: key);

  @override
  State<CountryCityListScreenLayout> createState() => _CountryCityListScreenLayoutState();
}

class _CountryCityListScreenLayoutState extends State<CountryCityListScreenLayout> {

  String _selectedCountry = '';
  String _selectedCity = '';

  final MultiSelectController propController = MultiSelectController();
  var myOptions = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dependant Test'),
      ),
      body: Column(
        children: [
          BlocBuilder<CountryCityBloc, CountryCityState>(
            builder: (context, state) {
              if (state.status == CountryCityStatus.initial) {
                context.read<CountryCityBloc>().add(LoadAllCountries());
              }
              if (state.status == CountryCityStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }  if (state.status == CountryCityStatus.success) {
                return Column(
                  children: [
                    DropdownButtonFormField<String>(
                      hint: const Text('Select Country'),
                      // value: state.selectedCountry ?? state.countries!.first,
                      value: state.selectedCountry,
                      items: state.countries!.map((country) => DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountry = value!;
                          _selectedCity = ''; // Reset selected city when country changes
                        });
                        context.read<CountryCityBloc>().add(LoadSelectedCountry(value!));
                        print('My Selected Country = ${_selectedCountry}');
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a country';
                        }
                        return null;
                      },
                    ),
                    if (_selectedCountry.isNotEmpty)
                      DropdownButtonFormField<String>(
                        hint:  Text('Select City'),
                        value: state.cities!.first,
                        items: state.cities!.map((city) => DropdownMenuItem<String>(
                          value: city.toString(),
                            child: Text(city) ) ).toList(),
                        // items: state.cities!
                        //     .where((city) => city.startsWith(_selectedCountry))
                        //     .map((city) => DropdownMenuItem<String>(
                        //   value: city,
                        //   child: Text(city),
                        // )).toList(),
                        onChanged: (value) {
                          setState(() => _selectedCity = value!);
                        },
                      ),
                  ],
                );
              }    if (state.status == CountryCityStatus.empty) {
                return const Center(
                  child: Text('No Data'),
                );
              }
              if (state.status == CountryCityStatus.error) {
                return const Center(
                  child: Text('An error occurred'),
                );
              }
              return Container();
            },
          ),

          SizedBox(height: 10.h,),

          BlocBuilder<PropertyBloc, PropertyState>(
  builder: (context, state) {
    if (state.status == PropertyStatus.initial) {
      // context.read<PropertyBloc>().add(LoadPropertiesEvent());
    }
    if (state.status == PropertyStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.status == PropertyStatus.success) {
      return MultiSelectDropDown(
        controller: propController,
        inputDecoration: BoxDecoration(
          color: AppTheme.fillColor,
          borderRadius: BorderRadius.circular(10),
        ),
        hint: 'Select periods',
        hintStyle: TextStyle(
          color: AppTheme.inActiveColor,
          fontSize: 16,
        ),

        onOptionSelected: (options) {
          for (var element in options) {
            print('My element = $element');

            myOptions = options.map((e) => e.value).toList();
            print('My options = $myOptions');
          }
        },
        options: state.properties!
            .map((property) {
          // initialBalance = schedule.balance!;
          return ValueItem(
            label:
            '${property.name}',
            value: property.id,
          );
        }
        )
            .toList(),
        selectionType: SelectionType.multi,
        chipConfig:
        const ChipConfig(wrapType: WrapType.wrap,),
        borderColor: Colors.white,
        optionTextStyle: const TextStyle(fontSize: 16),
        selectedOptionIcon:
        const Icon(Icons.check_circle),

      );
    }
    if (state.status == PropertyStatus.empty) {
      return const Center(
        child: Text('No Data'),
      );
    }
    if (state.status == PropertyStatus.error) {
      return const Center(
        child: Text('An Error Occurred'),
      );
    }
    return Container();

  },
),
          
        ],
      ),
    );
  }
}
