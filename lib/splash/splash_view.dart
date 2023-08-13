import 'package:annapurna_finance/AppImages.dart';
import 'package:annapurna_finance/api_factory/prefs/pref_utils.dart';
import 'package:annapurna_finance/common_webview.dart';
import 'package:annapurna_finance/login/login_view.dart';
import 'package:annapurna_finance/notifier/providers.dart';
import 'package:annapurna_finance/widgets/ab_button.dart';
import 'package:annapurna_finance/widgets/ab_text_input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {


  @override
  void initState() {
    navigateScreen();
    super.initState();
  }

  Future<void> navigateScreen() async {
    bool isLoggedIn = await PrefUtils.getIsLoggedIn() ?? false;
    String url = await PrefUtils.getUrl() ?? '';
    ref.watch(authenticationProvider).onInit();

    Future.delayed(
      const Duration(seconds: 3),
          () {
        if(isLoggedIn){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CommonWebView(url: url),
              ));
        }else{
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ));
        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Image.asset(AppImages.waveOne, width: 300),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Image.asset(AppImages.waveTwo),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset(AppImages.logo, width: 350)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
