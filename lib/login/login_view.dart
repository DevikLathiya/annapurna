import 'package:annapurna_finance/AppImages.dart';
import 'package:annapurna_finance/NoNetwork.dart';
import 'package:annapurna_finance/common_webview.dart';
import 'package:annapurna_finance/forgot_password/forgotPasswordPage.dart';
import 'package:annapurna_finance/notifier/providers.dart';
import 'package:annapurna_finance/utils/theme_config.dart';
import 'package:annapurna_finance/widgets/ab_button.dart';
import 'package:annapurna_finance/widgets/ab_text_input.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _checkbox = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoNetwork(LoginView())));
      }

    });
  }
  final _formKey = GlobalKey<FormState>();
  // recording fieldInput
  String? inputtedValue;

  // you can add more fields if needed
  bool userInteracts() => inputtedValue != null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
          child: SizedBox(
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
                    Center(child: Image.asset(AppImages.logo, width: 250)),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        height: 420,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 25.0, left: 15, bottom: 20),
                                child: Text('Login',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ABTextInput(
                                iserror: ref.watch(authenticationProvider).loginresult?null:Colors.red,
                                autoValidator: AutovalidateMode.onUserInteraction,
                                textInputType: TextInputType.phone,
                                titleText: 'Username',
                                validator: (value) {
                                  if (inputtedValue != null && (value == null || value.isEmpty)) {
                                    return 'Please enter username';
                                  }return null;
                                },
                                onChange: (value) => setState(() => inputtedValue = value),
                                controller: _userNameController,
                                hintText: 'Enter Username',
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ABTextInput(
                                  iserror: ref.watch(authenticationProvider).loginresult?null:Colors.red,
                                  titleText: 'Password',
                                  validator: (value) {
                                    if (inputtedValue != null && (value == null || value.isEmpty || value.length <= 6 )) {
                                      return 'Enter Valid Password';
                                    }
                                    return null;
                                  },
                                  onChange: (value) => setState(() => inputtedValue = value),
                                  controller: _passwordController,
                                  hintText: 'Enter Password',
                                  isPassword: _isObscure,
                                  suffix: IconButton(
                                    color: ThemeColor.primary,
                                    icon: Icon(_isObscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  children: [
                                    ref.watch(authenticationProvider).loginresult?SizedBox():Icon(Icons.warning_amber,color: Colors.red,size: 15,),
                                    ref.watch(authenticationProvider).loginresult?SizedBox():Text("The username or password is incorrect!",style: TextStyle(color: Colors.red,fontSize: 12)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(activeColor: Colors.deepPurple,
                                    value: _checkbox,
                                    onChanged: (value) {
                                      setState(() {
                                        _checkbox = !_checkbox;
                                      });
                                    },
                                  ),
                                  Text('Remember Me'),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => forgotPasswordPage(),));
                                    },
                                    child: Text('Forget Password?',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ],
                              ),
                              ABButton(
                                paddingTop: MediaQuery.of(context).size.height * 0.0225,
                                paddingBottom: 15.0,
                                paddingLeft: 20.0,
                                paddingRight: 20.0,
                                text: 'LOGIN',
                                onPressed: (!userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate()) ? null :() {
                                  ref.watch(authenticationProvider).loginAPI(
                                          context: context,
                                          userName: _userNameController.text,
                                          password: _passwordController.text,
                                        );
                                },

                              ),
                              // Text("${ref.watch(authenticationProvider).loginresult}"),
                              // Text("${(!userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate()) && !ref.watch(authenticationProvider).loginresult}")
                            ],

                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
