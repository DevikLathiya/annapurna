import 'package:annapurna_finance/api_factory/base_view_model.dart';
import 'package:annapurna_finance/login/viewmodels/authentication_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticationProvider = ChangeNotifierProvider(
      (_) => AuthenticationViewModel(),
);

final baseViewModel = ChangeNotifierProvider(
      (_) => BaseViewModel(),
);
