import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';

class CountryCodePickerProvider with ChangeNotifier {
  Country country =
      Country(isoCode: 'IN', iso3Code: 'IND', phoneCode: '91', name: 'india');

  void setCountry({required Country newCountry}) {
    country = newCountry;
    notifyListeners();
  }
}
