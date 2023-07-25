import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/authentication/provider/country_code_picker_provider.dart';
import 'package:mytune/general/serveices/constants.dart';
import 'package:provider/provider.dart';

class ContryPickerWidget extends StatelessWidget {
  const ContryPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryCodePickerProvider>(
      builder: (context, state, _) => InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.blue,
                ),
                child: CountryPickerDialog(
                  titlePadding: const EdgeInsets.all(8.0),

                  searchInputDecoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: '  Search...',
                  ),
                  isSearchable: true,
                  title: const Text('Select your country code'),
                  onValuePicked: (Country pickcountry) {
                    state.setCountry(newCountry: pickcountry);
                  },

                  //itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                  priorityList: const [
                    // CountryPickerUtils.getCountryByIsoCode(
                    //     'GB'),
                    // CountryPickerUtils.getCountryByIsoCode(
                    //     'CN'),
                  ],
                  itemBuilder: (Country country) => Row(
                    children: <Widget>[
                      CountryPickerUtils.getDefaultFlagImage(country),
                      kSizedBoxW5,
                      Text(
                        "+${country.phoneCode}(${country.isoCode})",
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )),
          );
        },
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(state.country),
            kSizedBoxW5,
            Text(
              "+${state.country.phoneCode}",
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 15),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
