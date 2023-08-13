import 'package:annapurna_finance/login/login_view.dart';
import 'package:annapurna_finance/utils/strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
class NoNetwork extends StatefulWidget {
  Widget? w;
   NoNetwork([this.w]);

  @override
  State<NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/no_network.png', fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'No Internet connection found',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Check your connection',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Connectivity().checkConnectivity().then((value) {
                        if (value == ConnectivityResult.none) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoNetwork(widget.w)));
                        }
                        else
                        {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.w!));
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Tap to retry',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16.0,
                            color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
