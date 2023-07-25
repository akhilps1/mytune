import 'package:flutter/material.dart';
import 'package:mytune/features/account/screens/account_page.dart';
import 'package:mytune/features/category/screens/category_page.dart';
import 'package:mytune/features/favorate/screens/favorate_page.dart';
import 'package:mytune/features/home/screens/home_page.dart';

const kSizedBoxW5 = SizedBox(
  width: 5,
);

const kSizedBoxH5 = SizedBox(
  height: 5,
);

const kSizedBoxH20 = SizedBox(
  height: 20,
);

const pages = [
  HomePage(),
  CategoryPage(),
  FavoratePage(),
  AccountsPage(),
];
