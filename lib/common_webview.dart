import 'package:annapurna_finance/NoNetwork.dart';
import 'package:annapurna_finance/api_factory/base_view_model.dart';
import 'package:annapurna_finance/notification_webview.dart';
import 'package:annapurna_finance/notifier/providers.dart';
import 'package:annapurna_finance/utils/dialogs.dart';
import 'package:annapurna_finance/utils/utils.dart';
import 'package:annapurna_finance/widgets/button_second.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AppImages.dart';
import 'login/login_view.dart';

class CommonWebView extends ConsumerStatefulWidget {
  const CommonWebView({required this.url, Key? key}) : super(key: key);
  final String url;

  @override
  ConsumerState<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends ConsumerState<CommonWebView> {
 // late InAppWebViewController _webViewController;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  String url = "";
  double progress = 0;

  String name = 'N/A';

  String role = 'N/A';

  String empId = 'N/A';
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoNetwork(CommonWebView(url: widget.url,))));
      }

    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      setState(() {
        name = "${ref.watch(authenticationProvider).kCurrentUser?.userName}".toUpperCase();
        role = "${ref.watch(authenticationProvider).kCurrentUser?.userRole}";
        empId = "EMP ID: ${ref.watch(authenticationProvider).kCurrentUser?.userid}";

      });

    });
    super.initState();
  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Image.asset(AppImages.logo, width: 200),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // GestureDetector(
          //   onTap: (){
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>  const NotificationWebView(url: 'http://maximoglobalsystems.com/main/landing/staff/notfication'),
          //         ));
          //
          //   },
          //   child: const Padding(
          //     padding: EdgeInsets.all(4.0),
          //     child: Icon(Icons.notifications_active),
          //   ),
          // ),
          GestureDetector(
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: '100',
              );
              await launchUrl(launchUri);            },
            child:  Padding(
              padding: EdgeInsets.all(4.0),
              child: Image.asset("assets/images/help.png",height: 30,width: 30,),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(Icons.person_outline),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 55,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 30.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://miro.medium.com/max/1400/1*-6WdIcd88w3pfphHOYln3Q.png',
                      ),
                      radius: 30.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      ref.watch(authenticationProvider).kCurrentUser!= null ? "${ref.watch(authenticationProvider).kCurrentUser?.userName}".toUpperCase(): '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text("${ref.watch(authenticationProvider).kCurrentUser?.userRole}",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text("EMP ID: ${ref.watch(authenticationProvider).kCurrentUser?.userid}",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AppImages.newApplication, width: 30),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        if (_scaffoldKey.currentState!.isDrawerOpen) {
                          _scaffoldKey.currentState!.openEndDrawer();
                        } else {
                          _scaffoldKey.currentState!.openDrawer();
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommonWebView(url: widget.url),
                            ));
                        // Navigator.pop(context);
                      },
                      child: const Text(
                        'Dashboard',
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AppImages.laf, width: 30),
                  ),
                   Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  NotificationWebView(url: 'http://maximoglobalsystems.com/main/landing/reportview/${ref.watch(authenticationProvider).kCurrentUser?.userid}'),
                            ));
                      },
                      child: const Text(
                        'Report View',
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AppImages.luc, width: 30),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  NotificationWebView(url: 'http://maximoglobalsystems.com/main/landing/passwordchange/${ref.watch(authenticationProvider).kCurrentUser?.userid}'),
                            ));
                      },
                      child: const Text(
                        'Reset Password',
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                  )
                ],
              ),
            ),
            // const Divider(
            //   thickness: 1,
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Image.asset(AppImages.village, width: 30),
            //       ),
            //        Expanded(
            //         child: GestureDetector(
            //           onTap: (){
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) =>  const NotificationWebView(url: 'http://maximoglobalsystems.com/main/landing/help'),
            //                 ));
            //           },
            //           child: Text(
            //             'Help',
            //             style:
            //             TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       ),
            //       const Padding(
            //         padding: EdgeInsets.all(4.0),
            //         child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
            //       )
            //     ],
            //   ),
            // ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PBButtonSecond(
                color: Colors.white,
                onPressed: () {
                  showLogoutDialog(context, "${ref.watch(authenticationProvider).kCurrentUser?.userid}");
                },
                child: const Text(
                  'Logout',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return Text(
                        "Version : ${snapshot.data!.version}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )

          ],

        ),
      ),
      // body: SafeArea(
      //   child: SizedBox(
      //     height: double.infinity,
      //     child: Column(children: <Widget>[
      //       progress < 1.0
      //           ? LinearProgressIndicator(value: progress)
      //           : Container(),
      //       Expanded(
      //         child: Container(
      //           child: InAppWebView(
      //             initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
      //             initialOptions: InAppWebViewGroupOptions(
      //               crossPlatform: InAppWebViewOptions(
      //                 javaScriptEnabled: true,
      //                 javaScriptCanOpenWindowsAutomatically: true,
      //                 mediaPlaybackRequiresUserGesture: false,
      //               ),
      //             ),
      //             onWebViewCreated: (InAppWebViewController controller) {
      //               _webViewController = controller;
      //             },
      //             onProgressChanged:
      //                 (InAppWebViewController controller, int progress) {
      //               setState(() {
      //                 this.progress = progress / 100;
      //               });
      //             },
      //           ),
      //         ),
      //       ),
      //     ]),
      //   ),
      // ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          geolocationEnabled: true,//support geolocation or not
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(content: Text(message.message)),
          // );
          handleApiError(message.message, context);
        });
  }
}
// children: [
//   const SizedBox(
//     height: 55,
//   ),
//   Row(
//     children: [
//       const Padding(
//         padding: EdgeInsets.all(10.0),
//         child: CircleAvatar(
//           backgroundColor: Colors.black,
//           radius: 30.0,
//           child: CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://miro.medium.com/max/1400/1*-6WdIcd88w3pfphHOYln3Q.png',
//             ),
//             radius: 30.0,
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${ref.watch(authenticationProvider).kCurrentUser?.userName}".toUpperCase(),
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold, fontSize: 17),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text("${ref.watch(authenticationProvider).kCurrentUser?.userRole}",
//               ),
//             ),
//           ],
//         ),
//       )
//     ],
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.newApplication, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'New Application',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.laf, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'LAF Status',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.luc, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'LUC Check',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.village, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'Village Addition',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.cb, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'CB Deviation Approval',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.fee, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'Fees and Charges',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.notifications, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'Notification',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.help, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'Help',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppImages.change, width: 30),
//         ),
//         const Expanded(
//           child: Text(
//             'Change Password',
//             style:
//                 TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//         )
//       ],
//     ),
//   ),
//   const Divider(
//     thickness: 1,
//   ),
//   Padding(
//     padding: const EdgeInsets.all(15.0),
//     child: PBButtonSecond(
//       color: Colors.white,
//       onPressed: () {
//         showLogoutDialog(context, "${ref.watch(authenticationProvider).kCurrentUser?.userid}");
//       },
//       child: const Text(
//         'Logout',
//       ),
//     ),
//   ),
//   Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: FutureBuilder<PackageInfo>(
//       future: PackageInfo.fromPlatform(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data != null) {
//             return Text(
//               "Version : ${snapshot.data!.version}",
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black
//               ),
//             );
//           } else {
//             return const SizedBox.shrink();
//           }
//         } else {
//           return const SizedBox.shrink();
//         }
//       },
//     ),
//   )
//
// ],