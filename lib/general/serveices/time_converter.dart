//created method for date time convert to time based
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String postedDateTime(DateTime createAt) {
  final differnce = DateTime.now().difference(createAt);

  if (differnce.inSeconds < 60) {
    return '${differnce.inSeconds} seconds ago';
  }
  if (differnce.inSeconds > 60 && differnce.inMinutes < 60) {
    debugPrint('Date in Minite:${differnce.inMinutes}');
    return '${differnce.inMinutes} minites ago';
  }
  if (differnce.inMinutes > 60 && differnce.inHours < 24) {
    debugPrint('Date in Hourse:${differnce.inHours}');

    return ' ${differnce.inHours} hours ago';
  }
  return DateFormat.MMMd().format(createAt);
}
