import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_service_planner/Enums/Colors.dart';
import 'package:multi_service_planner/modals/OrganizeEventProvider.dart';
import 'package:provider/provider.dart';

class PriceRangeFilter extends StatefulWidget {
  @override
  _PriceRangeFilterState createState() => _PriceRangeFilterState();
}

class _PriceRangeFilterState extends State<PriceRangeFilter> {
  RangeValues _selectedRange = RangeValues(0, 1000);
  double _minPrice = 0.0;
  double _maxPrice = 1000000.0;

  double _top = 0;

  @override
  void initState() {
    _selectedRange = RangeValues(_minPrice, _maxPrice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var OrgEventProv = Provider.of<OrganizeEventProvider>(context,listen:false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Text(
          "What's your price range?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.sizeOf(context).height*0.020),
        ),
        SizedBox(height: 20),
        Text(
          'PKR ${_selectedRange.start.toStringAsFixed(0)} - ${_selectedRange.end.toStringAsFixed(0)}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.sizeOf(context).height*0.032),
        ),
        RangeSlider(
          activeColor: appPrimary,
          inactiveColor: Color(0xffada8a8),
          values: _selectedRange,
          min: _minPrice,
          max: _maxPrice,
          onChanged: (RangeValues values) {
            setState(() {
              _selectedRange = values;
            });

            OrgEventProv.priceRangeStart = _selectedRange.start.toStringAsFixed(0);
            OrgEventProv.priceRangeEnd = _selectedRange.end.toStringAsFixed(0);
          },
          labels: RangeLabels(
            "PKR ${_selectedRange.start.toStringAsFixed(0)}",
            "PKR ${_selectedRange.end.toStringAsFixed(0)}",
          ),
        ),

      ],
    );
  }
}
