import 'package:annapurna_finance/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../api_factory/base_view_model.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SizedBox(
        height: 50.0.h,
        width: 50.0.w,
        child: const FittedBox(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.deepPurpleAccent,
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
showLogoutDialog(BuildContext context, String userId) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      title: Text(
        'Logout',style: TextStyle(color: ThemeColor.primary)
      ),
      content: Text(
      'Are you sure you want to logout?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text(
           'Cancel',style: TextStyle(color: ThemeColor.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            var viewModel = BaseViewModel();
            viewModel.logoutUserAPI(context: context, userId: userId);
          },
          child: Text(
            'Logout',
            style: TextStyle(color: ThemeColor.primary),
          ),
        ),
      ],
    ),
  );
}

hideLoading(BuildContext context) {
  Navigator.pop(context);
}

