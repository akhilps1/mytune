import 'package:flutter/material.dart';
import 'package:mytune/features/account/screens/account_page.dart';
import 'package:mytune/features/artists/screens/category_page.dart';
import 'package:mytune/features/favorate/screens/favorate_page.dart';
import 'package:mytune/features/home/screens/home_page.dart';
import 'package:mytune/features/trending/screens/trending_page.dart';

const kSizedBoxW5 = SizedBox(
  width: 5,
);

const kSizedBoxH5 = SizedBox(
  height: 5,
);

const kSizedBoxH20 = SizedBox(
  height: 20,
);
const kSizedBoxH15 = SizedBox(
  height: 15,
);
const kSizedBoxH40 = SizedBox(
  height: 40,
);

const pages = [
  HomePage(),
  CategoryPage(),
  TrendingPage(),
  FavoratePage(),
  AccountsPage(),
];
